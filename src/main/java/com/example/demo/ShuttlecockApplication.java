package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class ShuttlecockApplication {

	public static void main(String[] args) {
		SpringApplication.run(ShuttlecockApplication.class, args);
		System.out.println("서버 생성");
	}

}
