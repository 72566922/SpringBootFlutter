//SPRINGBOOTFLUTTER/jorgecolors/src/main/java/com/jorgecolors/jorgecolors/Roles/Rol.java
package com.jorgecolors.jorgecolors.Roles;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "rol")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Rol {
    @Id
    @GeneratedValue
    private Integer id_rol;
    private String rol;
    private String descripcion;
    private double salario;
    private String habilitar;

    public String getHabilitar() {
        return habilitar;
    }

    public void setHabilitar(String habilitar) {
        this.habilitar = habilitar;
    }
}

