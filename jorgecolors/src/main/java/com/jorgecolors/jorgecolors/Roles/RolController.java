//SPRINGBOOTFLUTTER/jorgecolors/src/main/java/com/jorgecolors/jorgecolors/Roles/RolController.java
package com.jorgecolors.jorgecolors.Roles;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;

import java.util.List;

@RestController
@RequestMapping("/rol")
@RequiredArgsConstructor
public class RolController {
    private final RolService rolService;

    @GetMapping
    public ResponseEntity<List<Rol>> getRoles() {
        List<Rol> roles = rolService.obtenerTodasRoles();
        return ResponseEntity.ok(roles);
    }

    @PostMapping
    public ResponseEntity<Rol> addRoles(@RequestBody Rol rol) {
        Rol nuevoRol = rolService.guardarRoles(rol);
        return ResponseEntity.status(201).body(nuevoRol);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteRoles(@PathVariable int id) {
        rolService.eliminarRoles(id);
        return ResponseEntity.noContent().build();
    }
}
