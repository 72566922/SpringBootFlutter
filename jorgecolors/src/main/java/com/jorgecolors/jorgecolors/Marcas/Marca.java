package com.jorgecolors.jorgecolors.Marcas;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "marcas")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Marca {
    @Id
    @GeneratedValue 
    private Integer id_marcas;
    private String marca;
    private String habilitar;

    public String getHabilitar() {
        return habilitar;
    }

    public void setHabilitar(String habilitar) {
        this.habilitar = habilitar;
    }
}
