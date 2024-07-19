package com.jorgecolors.jorgecolors.Productos;


import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "productos")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Producto {
    
    @Id
    @GeneratedValue 
    private Integer id_productos;
    private String color;
    private double p_costo; // Cambiado a int según tu estructura
    private double p_venta; // Cambiado a int según tu estructura
    private int id_marcas; // Cambiado a int según tu estructura
    private int id_categoria; // Cambiado a int según tu estructura
    private int cantidad;
    private String habilitar;

    // Getters y Setters para todos los campos (generados automáticamente por Lombok)

    public String getHabilitar() {
        return habilitar;
    }
    
    public void setHabilitar(String habilitar) {
        this.habilitar = habilitar;
    }
}
