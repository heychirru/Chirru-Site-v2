package com.chirru.portfolio.controller;

import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.CacheControl;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestClient;

import java.util.Optional;
import java.util.concurrent.TimeUnit;

@RestController
@RequiredArgsConstructor
public class PublicResumeController {
    private static final Logger log = LoggerFactory.getLogger(PublicResumeController.class);

    private final JdbcTemplate jdbc;
    private final RestClient restClient = RestClient.builder().build();

    @GetMapping("/portfolio/resume")
    public ResponseEntity<byte[]> resume() {
        Optional<String> maybeUrl = activeResumeUrl().or(this::profileResumeUrl);
        if (maybeUrl.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        String url = maybeUrl.get();
        try {
            ResponseEntity<byte[]> upstream = restClient.get()
                    .uri(url)
                    .retrieve()
                    .toEntity(byte[].class);

            byte[] body = upstream.getBody();
            if (body == null || body.length == 0) {
                return ResponseEntity.notFound().build();
            }

            MediaType contentType = upstream.getHeaders().getContentType();
            if (contentType == null || contentType.equals(MediaType.APPLICATION_OCTET_STREAM)) {
                contentType = MediaType.APPLICATION_PDF;
            }

            return ResponseEntity.ok()
                    .contentType(contentType)
                    .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"resume.pdf\"")
                    .cacheControl(CacheControl.maxAge(1, TimeUnit.HOURS).cachePublic())
                    .header(HttpHeaders.ACCESS_CONTROL_ALLOW_ORIGIN, "*")
                    .body(body);
        } catch (Exception e) {
            log.warn("Failed to stream resume PDF from Cloudinary URL {}: {}", url, e.getMessage());
            return ResponseEntity.notFound().build();
        }
    }

    private Optional<String> activeResumeUrl() {
        return firstUrl("SELECT url FROM resume_versions WHERE active=true AND NULLIF(TRIM(url),'') IS NOT NULL ORDER BY created_at DESC LIMIT 1");
    }

    private Optional<String> profileResumeUrl() {
        return firstUrl("SELECT resume_url FROM profile WHERE NULLIF(TRIM(resume_url),'') IS NOT NULL ORDER BY updated_at DESC LIMIT 1");
    }

    private Optional<String> firstUrl(String sql) {
        return jdbc.queryForList(sql, String.class).stream()
                .map(String::trim)
                .findFirst();
    }
}
