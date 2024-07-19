package com.jorgecolors.jorgecolors.Marcas;


import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;
import java.util.List;

@RestController
@RequestMapping("/marcas")
@RequiredArgsConstructor
public class MarcaController {
    private final MarcaService marcaService;

    @GetMapping
    public ResponseEntity<List<Marca>> getMarca() {
        List<Marca> marcas = marcaService.obtenerTodasMarca();
        return ResponseEntity.ok(marcas);
    }

    @PostMapping
    public ResponseEntity<Marca> addMarca(@RequestBody Marca marca) {
        Marca nuevaMarca = marcaService.guardarMarca(marca);
        return ResponseEntity.status(201).body(nuevaMarca);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteMarca(@PathVariable int id) {
        marcaService.eliminarMarca(id);
        return ResponseEntity.noContent().build();
    }
}
