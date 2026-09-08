package com.chirru.portfolio.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;

@RestController
@RequiredArgsConstructor
public class PublicResumeController {
    private final JdbcTemplate jdbc;

    @GetMapping("/portfolio/resume")
    public ResponseEntity<Void> resume() {
        return activeResumeUrl()
                .or(this::profileResumeUrl)
                .map(url -> ResponseEntity.status(HttpStatus.FOUND)
                        .header(HttpHeaders.LOCATION, url)
                        .<Void>build())
                .orElseGet(() -> ResponseEntity.notFound().build());
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
