//SPRINGBOOTFLUTTER/jorgecolors/src/main/java/com/jorgecolors/jorgecolors/Categoria/Categoria.java
package com.jorgecolors.jorgecolors.Categoria;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "categorias")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Categoria {
    @Id
    @GeneratedValue 
    private Integer id_categoria;
    private String categoria;
    private String description;
    private String habilitar;

    // Getters y Setters
    public String getHabilitar() {
        return habilitar;
    }

    public void setHabilitar(String habilitar) {
        this.habilitar = habilitar;
    }
}
