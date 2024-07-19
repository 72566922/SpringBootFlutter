//SPRINGBOOTFLUTTER/jorgecolors/src/main/java/com/jorgecolors/jorgecolors/Ventas/Ventajava
package com.jorgecolors.jorgecolors.Ventas;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "ventas")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Venta {
    @Id
    @GeneratedValue 
    private Integer id_venta;
    private int id_cliente;
    private int id_empleado; // Cambiado a int según tu estructura
    private int id_productos; // Cambiado a int según tu estructura
    private int unidades;
    private double total;

}
