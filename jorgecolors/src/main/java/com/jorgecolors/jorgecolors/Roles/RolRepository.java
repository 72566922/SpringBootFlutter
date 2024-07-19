//SPRINGBOOTFLUTTER/jorgecolors/src/main/java/com/jorgecolors/jorgecolors/Roles/RolRepository.java
package com.jorgecolors.jorgecolors.Roles;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RolRepository extends JpaRepository<Rol, Integer> {
    List<Rol> findByHabilitarNot(String habilitarEstado);
}
