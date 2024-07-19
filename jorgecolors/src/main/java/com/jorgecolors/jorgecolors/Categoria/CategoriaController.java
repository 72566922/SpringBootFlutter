//SPRINGBOOTFLUTTER/jorgecolors/src/main/java/com/jorgecolors/jorgecolors/Categoria/CategoriaController.java
package com.jorgecolors.jorgecolors.Categoria;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;
import java.util.List;

@RestController
@RequestMapping("/categorias")
@RequiredArgsConstructor
public class CategoriaController {
    
    private final CategoriaService categoriaService;

    @GetMapping
    public ResponseEntity<List<Categoria>> getCategorias() {
        List<Categoria> categorias = categoriaService.obtenerTodasCategorias();
        return ResponseEntity.ok(categorias);
    }

    @PostMapping
    public ResponseEntity<Categoria> addCategoria(@RequestBody Categoria categoria) {
        Categoria nuevaCategoria = categoriaService.guardarCategoria(categoria);
        return ResponseEntity.status(201).body(nuevaCategoria);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteCategoria(@PathVariable int id) {
        categoriaService.eliminarCategoria(id);
        return ResponseEntity.noContent().build();
    }
}
