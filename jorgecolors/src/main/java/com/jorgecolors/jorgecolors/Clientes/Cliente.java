//SPRINGBOOTFLUTTER/jorgecolors/src/main/java/com/jorgecolors/jorgecolors/Clientes/Cliente.java
package com.jorgecolors.jorgecolors.Clientes;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "clientes")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Cliente {
    
    @Id
    @GeneratedValue 
    private Integer id_cliente;
    private String dni;
    private String nombre;
    private String apellido;
    private String direccion;
    private int id_distrito; // Cambiado a int según tu estructura
    private String telefono;
    private String celular;
    private String correo;
    private String sexo;
    private String habilitar;

    // Getters y Setters para todos los campos (generados automáticamente por Lombok)

    public String getHabilitar() {
        return habilitar;
    }
    
    public void setHabilitar(String habilitar) {
        this.habilitar = habilitar;
    }

}
