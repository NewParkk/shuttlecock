package com.example.demo;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication(exclude = {SecurityAutoConfiguration.class})
//@ComponentScan(basePackages = "com.fp.shuttlecock")
@ComponentScan(basePackages = "com.fp")
@MapperScan(basePackages = "com.fp.shuttlecock")
public class ShuttlecockApplication {
	public static void main(String[] args) {
		SpringApplication.run(ShuttlecockApplication.class, args);
		System.out.println("서버 생성");
	}		
}
