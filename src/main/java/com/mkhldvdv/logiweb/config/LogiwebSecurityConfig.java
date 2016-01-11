package com.mkhldvdv.logiweb.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import javax.sql.DataSource;

/**
 * Created by mkhldvdv on 27.12.2015.
 */

@Configuration
@EnableWebSecurity
@Import({WebConfig.class})
public class LogiwebSecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    DataSource dataSource;

    @Autowired
    public void configAuthentication(AuthenticationManagerBuilder auth) throws Exception {

        auth.jdbcAuthentication().dataSource(dataSource)
                .passwordEncoder(passwordEncoder())
                .usersByUsernameQuery(
                        "select login, password, (enabled - deleted) from users where login = ?")
                .authoritiesByUsernameQuery(
                        "select u.login, r.role_name from users u, roles r where r.role_id = u.role_id and u.login = ?");
    }

    @Bean
    public PasswordEncoder passwordEncoder(){
        PasswordEncoder encoder = new BCryptPasswordEncoder();
        return encoder;
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {

        http.authorizeRequests()
                .antMatchers("/", "/welcome").permitAll()
                // operator pages
                .antMatchers("/addCargo").access("hasRole('OPERATOR')")
                .antMatchers("/addDriver").access("hasRole('OPERATOR')")
                .antMatchers("/addEditUser").access("hasRole('OPERATOR')")
                .antMatchers("/addOrder").access("hasRole('OPERATOR')")
                .antMatchers("/addOrderDrivers").access("hasRole('OPERATOR')")
                .antMatchers("/addOrderTruck").access("hasRole('OPERATOR')")
                .antMatchers("/addTruck").access("hasRole('OPERATOR')")
                .antMatchers("/deleteDriver").access("hasRole('OPERATOR')")
                .antMatchers("/deleteTruck").access("hasRole('OPERATOR')")
                .antMatchers("/editDriver").access("hasRole('OPERATOR')")
                .antMatchers("/editTruck").access("hasRole('OPERATOR')")
                .antMatchers("/error").access("hasRole('OPERATOR')")
                .antMatchers("/findCargo").access("hasRole('OPERATOR')")
                .antMatchers("/findOrder").access("hasRole('OPERATOR')")
                .antMatchers("/info").access("hasRole('OPERATOR')")
                .antMatchers("/listCargo").access("hasRole('OPERATOR')")
                .antMatchers("/listDrivers").access("hasRole('OPERATOR')")
                .antMatchers("/listOneOrder").access("hasRole('OPERATOR')")
                .antMatchers("/listOrders").access("hasRole('OPERATOR')")
                .antMatchers("/listTrucks").access("hasRole('OPERATOR')")
                .antMatchers("/success").access("hasRole('OPERATOR')")
                .antMatchers("/userProfile").access("hasRole('OPERATOR')")
                // drivers pages
                .antMatchers("/infoDriver").access("hasRole('DRIVER')")
                .antMatchers("/infoForDriver").access("hasRole('DRIVER')")
                .antMatchers("/driverProfile").access("hasRole('DRIVER')")
                .antMatchers("/errorDriver").access("hasRole('DRIVER')")
                .and()

                // login form
                .formLogin().loginPage("/login")
                .usernameParameter("j_username").passwordParameter("j_password")
                .and().exceptionHandling().accessDeniedPage("/AccessDenied")
                .and().csrf().disable()
//                .loginProcessingUrl("/info")
//                .defaultSuccessUrl("/info")
//                .and().csrf()
//                .and()
//
                // logout
                .logout()
                .logoutRequestMatcher( new AntPathRequestMatcher("/logout") )
                .logoutSuccessUrl("/welcome?logout")
                .deleteCookies("JSESSIONID")
                .invalidateHttpSession( true );
    }
}
