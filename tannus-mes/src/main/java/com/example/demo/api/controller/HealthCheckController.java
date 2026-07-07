package com.example.demo.api.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
    @RequestMapping("/health-check")
    public class HealthCheckController {

        @GetMapping
        public ResponseEntity healthCheck() {
            return ResponseEntity.ok().build();
        }

        @GetMapping("/v2")
        public ResponseEntity<Map<String, String>> healthCheckV2() {
            Map<String, String> body = new HashMap<>();
            body.put("status", "UP");
            return ResponseEntity.ok(body);
        }
    }

