package com.fp.global.Config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.fp.global.interceptor.AutoLoginInterceptor;
import com.fp.global.interceptor.LoginInterCeptor;

@Configuration
public class WebConfig implements WebMvcConfigurer {
	
	@Autowired
	private LoginInterCeptor loginInterCeptor;
	
	@Autowired
	private AutoLoginInterceptor autoLoginInterceptor;
	
	//인터셉터 추가
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
    
    //Cors(Cross-Origin Resource Sharing)설정 추가
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowedMethods("*")
                .allowedOrigins("http://client");
    }
    
    //error 처리
    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        // 404 에러가 발생하면 /view/error/error_404.jsp로 이동하도록 설정
        registry.addViewController("/error/404").setViewName("error/error_404");
        registry.addViewController("/error/500").setViewName("error/error_500");
    }
    
}