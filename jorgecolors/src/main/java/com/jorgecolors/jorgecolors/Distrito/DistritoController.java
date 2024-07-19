//SPRINGBOOTFLUTTER/jorgecolors/src/main/java/com/jorgecolors/jorgecolors/Distrito/DistritoController.java
package com.jorgecolors.jorgecolors.Distrito;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;
import java.util.List;

@RestController
@RequestMapping("/distrito")
@RequiredArgsConstructor
public class DistritoController {
    
    private final DistritoService distritoService;

    @GetMapping
    public ResponseEntity<List<Distrito>> getDistrito() {
        List<Distrito> distrito = distritoService.obtenerTodasDistrito();
        return ResponseEntity.ok(distrito);
    }

    @PostMapping
    public ResponseEntity<Distrito> addDistrito(@RequestBody Distrito distrito) {
        Distrito nuevaDistrito = distritoService.guardarDistrito(distrito);
        return ResponseEntity.status(201).body(nuevaDistrito);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteDistrito(@PathVariable int id) {
        distritoService.eliminarDistrito(id);
        return ResponseEntity.noContent().build();
    }
}
