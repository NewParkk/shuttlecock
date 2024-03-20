package com.fp.global.Config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.fp.global.interceptor.AutoLoginInterceptor;
import com.fp.global.interceptor.LoginInterCeptor;

@Configuration
public class WebConfig implements WebMvcConfigurer {
	
	@Autowired
	private LoginInterCeptor loginInterCeptor;
	
	@Autowired
	private AutoLoginInterceptor autoLoginInterceptor;
	
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
    	
    	//자동로그인 인터셉터
    	registry.addInterceptor(autoLoginInterceptor)
    	.addPathPatterns("/**");
    	
    	//로그인 인터셉터
        registry.addInterceptor(loginInterCeptor)
        		.excludePathPatterns("/login")
                .addPathPatterns("/mypage");
        
    }
    
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowedMethods("*")
                .allowedOrigins("http://client");
    }
    
}