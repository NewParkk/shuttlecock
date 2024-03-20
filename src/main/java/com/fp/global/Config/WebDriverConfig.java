package com.fp.global.Config;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class WebDriverConfig {
	
	@Bean
    public WebDriver webDriver() {
		/*
		 * String WEB_DRIVER_ID = "webdriver.chrome.driver"; String WEB_DRIVER_PATH =
		 * "C:\\multi\\00.dev\\chromedriver-win64\\chromedriver.exe";
		 */
        
        // WebDriver 설정
		/* System.setProperty(WEB_DRIVER_ID, WEB_DRIVER_PATH); */
		
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--headless"); // Headless 모드 설정

        WebDriver driver = new ChromeDriver(options);
        return driver;
    }
}
