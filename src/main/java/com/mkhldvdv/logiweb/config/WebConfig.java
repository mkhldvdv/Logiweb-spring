package com.mkhldvdv.logiweb.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

/**
 * Created by mkhldvdv on 26.12.2015.
 */

@EnableWebMvc
@Configuration
@ComponentScan("com.mkhldvdv.logiweb.controllers")
//@Import({LogiwebSecurityConfig.class})
public class WebConfig extends WebMvcConfigurerAdapter{

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
    }

    @Bean(name = "dataSource")
    public DriverManagerDataSource dataSource() {
        DriverManagerDataSource driverManagerDataSource = new DriverManagerDataSource();
        driverManagerDataSource.setDriverClassName("oracle.jdbc.driver.OracleDriver");
//        driverManagerDataSource.setDriverClassName("com.mysql.jdbc.Driver");
//        driverManagerDataSource.setUrl("jdbc:mysql://localhost:3306/test");
        driverManagerDataSource.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
        driverManagerDataSource.setUsername("logiweb");
        driverManagerDataSource.setPassword("logiweb");
        return driverManagerDataSource;
    }

    @Bean
    public InternalResourceViewResolver viewResolver() {
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setViewClass(JstlView.class);
        viewResolver.setPrefix("/WEB-INF/jsp/");
        viewResolver.setSuffix(".jsp");
        return viewResolver;
    }
}
