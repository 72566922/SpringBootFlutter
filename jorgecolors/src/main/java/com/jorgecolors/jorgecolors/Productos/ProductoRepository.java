package com.jorgecolors.jorgecolors.Productos;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductoRepository extends JpaRepository<Producto, Integer>{

    // Método para obtener todas las categorías habilitadas
    List<Producto> findByHabilitarNot(String habilitarEstado);
    
} 
