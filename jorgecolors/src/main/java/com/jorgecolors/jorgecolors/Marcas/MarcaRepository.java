package com.jorgecolors.jorgecolors.Marcas;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MarcaRepository extends JpaRepository<Marca, Integer>{
    
    // Método para obtener todas las categorías habilitadas
    List<Marca> findByHabilitarNot(String habilitarEstado);
}
