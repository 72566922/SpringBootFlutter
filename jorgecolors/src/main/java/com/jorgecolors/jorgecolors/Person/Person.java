package com.jorgecolors.jorgecolors.Person;

import jakarta.persistence.Basic;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType; // Agrega esto para especificar la estrategia de generación de ID
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
public class Person {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Especifica la estrategia de generación de ID
    private Integer id_person;
    @Basic
    private String email;
    private String username;
    private String password;
}
