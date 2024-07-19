//SPRINGBOOTFLUTTER/jorgecolors/src/main/java/com/jorgecolors/jorgecolors/Empleados/Empleado.java
package com.jorgecolors.jorgecolors.Empleados;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "empleados")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Empleado {
    @Id
    @GeneratedValue 
    private Integer id_empleado;
    private String dni;
    private String nombre;
    private String apellido;
    private String direccion;
    private int id_distrito; // Cambiado a int según tu estructura
    private int id_rol; // Cambiado a int según tu estructura
    private String telefono;
    private String celular;
    private String correo;
    private int edad;
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


