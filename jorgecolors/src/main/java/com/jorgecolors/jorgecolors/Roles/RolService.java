//SPRINGBOOTFLUTTER/jorgecolors/src/main/java/com/jorgecolors/jorgecolors/Roles/RolService.java
package com.jorgecolors.jorgecolors.Roles;

import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;

import java.util.List;

@Service
@RequiredArgsConstructor
public class RolService {
    
    private final RolRepository rolRepo;

    public Rol guardarRoles(Rol rol) {
        return rolRepo.save(rol);
    }

    public void eliminarRoles(int id) {
        rolRepo.deleteById(id);
    }

    public List<Rol> obtenerTodasRoles() {
        return rolRepo.findAll();
    }
}
