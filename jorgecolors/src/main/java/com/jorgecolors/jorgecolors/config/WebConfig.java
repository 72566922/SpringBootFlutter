//SPRINGBOOTFLUTTER/jorgecolors/src/main/java/com/jorgecolors/jorgecolors/config/WebConfig.java

package com.jorgecolors.jorgecolors.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**") // Permite solicitudes desde cualquier origen
                .allowedOrigins("http://192.168.1.44:56315") // Cambia a tu origen específico
                .allowedMethods("GET", "POST", "PUT", "DELETE") // Métodos HTTP permitidos
                .allowedHeaders("*") // Headers permitidos (puedes ajustar según necesidades)
                .allowCredentials(true); // Permite credenciales como cookies, si es necesario
    }
}
