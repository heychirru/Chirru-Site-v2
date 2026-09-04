package com.chirru.portfolio.controller;

import com.chirru.portfolio.service.CloudinaryService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

@RestController
@RequestMapping("/admin/media")
@RequiredArgsConstructor
@PreAuthorize("hasRole('ADMIN')")
public class MediaController {
    private final CloudinaryService cloudinaryService;

    @PostMapping("/{folder}")
    @ResponseStatus(HttpStatus.CREATED)
    public Map<String, Object> upload(@PathVariable String folder, @RequestParam("file") MultipartFile file) {
        CloudinaryService.UploadFolder uploadFolder = CloudinaryService.UploadFolder.from(folder);
        CloudinaryService.UploadResult result = cloudinaryService.upload(file, uploadFolder);
        return Map.of("url", result.url(), "publicId", result.publicId(), "resourceType", result.resourceType(), "format", result.format() == null ? "" : result.format());
    }

    @DeleteMapping
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void delete(@RequestParam String publicId, @RequestParam(defaultValue = "image") String resourceType) {
        cloudinaryService.delete(publicId, resourceType);
    }
}
