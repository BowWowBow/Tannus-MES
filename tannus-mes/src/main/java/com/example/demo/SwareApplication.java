package com.example.demo;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@MapperScan("com.example.demo.api.mapper")
@SpringBootApplication
public class SwareApplication {

	public static void main(String[] args) {
		SpringApplication.run(SwareApplication.class, args);
	}
}