//SPRINGBOOTFLUTTER/jorgecolors/src/main/java/com/jorgecolors/jorgecolors/Categoria/CategoriaRepository.java
package com.jorgecolors.jorgecolors.Categoria;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface CategoriaRepository extends JpaRepository<Categoria, Integer> {

    // Método para obtener todas las categorías habilitadas
    List<Categoria> findByHabilitarNot(String habilitarEstado);
}
