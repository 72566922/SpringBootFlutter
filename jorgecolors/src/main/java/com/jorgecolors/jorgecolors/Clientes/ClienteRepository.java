//SPRINGBOOTFLUTTER/jorgecolors/src/main/java/com/jorgecolors/jorgecolors/Clientes/ClienteRepository.java
package com.jorgecolors.jorgecolors.Clientes;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ClienteRepository extends JpaRepository<Cliente, Integer>{

    // Método para obtener todas las categorías habilitadas
    List<Cliente> findByHabilitarNot(String habilitarEstado);
    
} 
