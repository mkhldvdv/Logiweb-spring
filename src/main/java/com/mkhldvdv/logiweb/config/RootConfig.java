package com.mkhldvdv.logiweb.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;

/**
 * Created by mkhldvdv on 26.12.2015.
 */

@Configuration
@Import({LogiwebSecurityConfig.class})
public class RootConfig {
}
