//SPRINGBOOTFLUTTER/jorgecolors/src/main/java/com/jorgecolors/jorgecolors/Distrito/DistritoRepository.java
package com.jorgecolors.jorgecolors.Distrito;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


import java.util.List;

@Repository
public interface DistritoRepository extends JpaRepository<Distrito, Integer>{
    // Método para obtener todas las categorías habilitadas
    List<Distrito> findByHabilitarNot(String habilitarEstado);
}
