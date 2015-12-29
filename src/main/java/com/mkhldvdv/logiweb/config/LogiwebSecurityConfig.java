package com.mkhldvdv.logiweb.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import javax.sql.DataSource;

/**
 * Created by mkhldvdv on 27.12.2015.
 */

@Configuration
@EnableWebSecurity
@Import({WebConfig.class})
public class LogiwebSecurityConfig extends WebSecurityConfigurerAdapter {

//    @Autowired
//    public void configureGlobalSecurity(AuthenticationManagerBuilder auth) throws Exception {
//        auth.inMemoryAuthentication().withUser("admin").password("admin").roles("OPERATOR");
//        auth.inMemoryAuthentication().withUser("login445").password("driver").roles("DRIVER");
//    }

    @Autowired
    DataSource dataSource;

    @Autowired
    public void configAuthentication(AuthenticationManagerBuilder auth) throws Exception {

        auth.jdbcAuthentication().dataSource(dataSource)
                .usersByUsernameQuery(
                        "select first_name, password, enabled from users where login = ?")
                .authoritiesByUsernameQuery(
                        "select u.first_name, r.role_name from users u, roles r where r.role_id = u.role_id and u.login = ?");
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {

        http.authorizeRequests()
                .antMatchers("/", "/welcome").permitAll()
                .antMatchers("/infoDriver").access("hasRole('DRIVER')")
                .antMatchers("/info").access("hasRole('OPERATOR')")
                .and()

                // login form
                .formLogin().loginPage("/login")
                .usernameParameter("j_username").passwordParameter("j_password")
                .and().exceptionHandling().accessDeniedPage("/AccessDenied");
//                .loginProcessingUrl("/info")
//                .defaultSuccessUrl("/info")
//                .and().csrf()
//                .and()
//
//                // logout
//                .logout()
//                .logoutRequestMatcher( new AntPathRequestMatcher("/logout") )
//                .logoutSuccessUrl("/login")
//                .deleteCookies("JSESSIONID")
//                .invalidateHttpSession( true );
    }
}
