package com.chirru.portfolio.controller;

import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.CacheControl;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestClient;

import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.concurrent.TimeUnit;

@RestController
@RequestMapping("/images")
@RequiredArgsConstructor
public class ImageProxyController {

    private static final Logger log = LoggerFactory.getLogger(ImageProxyController.class);

    private final RestClient restClient = RestClient.builder().build();

    @GetMapping
    public ResponseEntity<byte[]> proxyImage(@RequestParam(name = "id") String encodedId) {
        // Decode the id param back to the original Cloudinary URL
        String cloudinaryUrl;
        try {
            cloudinaryUrl = URLDecoder.decode(encodedId, StandardCharsets.UTF_8);
        } catch (Exception e) {
            log.warn("Invalid id encoding: {}", encodedId);
            return ResponseEntity.badRequest().build();
        }

        // Basic safety check — only proxy URLs pointing to Cloudinary
        if (cloudinaryUrl == null || cloudinaryUrl.isBlank()) {
            return ResponseEntity.notFound().build();
        }
        if (!cloudinaryUrl.startsWith("https://res.cloudinary.com/") &&
            !cloudinaryUrl.startsWith("https://api.cloudinary.com/")) {
            log.warn("Proxy request for non-Cloudinary URL blocked: {}", cloudinaryUrl);
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }

        try {
            // Fetch bytes from Cloudinary (server-to-server, never exposed to browser)
            ResponseEntity<byte[]> upstream = restClient.get()
                    .uri(cloudinaryUrl)
                    .retrieve()
                    .toEntity(byte[].class);

            byte[] body = upstream.getBody();
            if (body == null || body.length == 0) {
                return ResponseEntity.notFound().build();
            }

            // Determine Content-Type from upstream response
            MediaType contentType = upstream.getHeaders().getContentType();
            if (contentType == null || contentType.equals(MediaType.APPLICATION_OCTET_STREAM)) {
                contentType = guessContentType(cloudinaryUrl);
            }

            ResponseEntity.BodyBuilder responseBuilder = ResponseEntity.ok()
                    .contentType(contentType)
                    .cacheControl(CacheControl.maxAge(24, TimeUnit.HOURS).cachePublic())
                    .header(HttpHeaders.ACCESS_CONTROL_ALLOW_ORIGIN, "*");

            if (MediaType.APPLICATION_PDF.equals(contentType) || cloudinaryUrl.toLowerCase().contains(".pdf")) {
                responseBuilder.header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"document.pdf\"");
            }

            return responseBuilder.body(body);

        } catch (Exception e) {
            log.warn("Failed to proxy image from Cloudinary: {} — {}", cloudinaryUrl, e.getMessage());
            return ResponseEntity.notFound().build();
        }
    }

    /**
     * Fallback content-type guesser from file extension when upstream header is absent.
     */
    private MediaType guessContentType(String url) {
        String lower = url.toLowerCase();
        if (lower.contains(".jpg") || lower.contains(".jpeg")) return MediaType.IMAGE_JPEG;
        if (lower.contains(".png")) return MediaType.IMAGE_PNG;
        if (lower.contains(".gif")) return MediaType.IMAGE_GIF;
        if (lower.contains(".webp")) return new MediaType("image", "webp");
        if (lower.contains(".svg")) return new MediaType("image", "svg+xml");
        if (lower.contains(".pdf")) return MediaType.APPLICATION_PDF;
        return MediaType.APPLICATION_OCTET_STREAM;
    }
}
