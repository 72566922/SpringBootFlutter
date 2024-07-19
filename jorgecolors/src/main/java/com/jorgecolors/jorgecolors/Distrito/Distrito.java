//SPRINGBOOTFLUTTER/jorgecolors/src/main/java/com/jorgecolors/jorgecolors/Distrito/Distrito.java
package com.jorgecolors.jorgecolors.Distrito;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "distrito")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Distrito {

    @Id
    @GeneratedValue 
    private Integer id_distrito;
    private String distrito;
    private String habilitar;

    public String getHabilitar() {
        return habilitar;
    }

    public void setHabilitar(String habilitar) {
        this.habilitar = habilitar;
    }
    
}
