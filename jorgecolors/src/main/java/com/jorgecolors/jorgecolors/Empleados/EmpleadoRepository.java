//SPRINGBOOTFLUTTER/jorgecolors/src/main/java/com/jorgecolors/jorgecolors/Empleados/EmpleadoRepository.java
package com.jorgecolors.jorgecolors.Empleados;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface EmpleadoRepository extends JpaRepository<Empleado, Integer> {

    // Método para obtener todas las categorías habilitadas
    List<Empleado> findByHabilitarNot(String habilitarEstado);
}
