package com.jorgecolors.jorgecolors.Productos;


import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import lombok.RequiredArgsConstructor;
import java.util.List;

@RestController
@RequestMapping("/productos")
@RequiredArgsConstructor
public class ProductoController {
    
    private final ProductoService productoService;

    @GetMapping
    public ResponseEntity<List<Producto>> getProducto() {
        List<Producto> producto = productoService.obtenerTodasProducto();
        return ResponseEntity.ok(producto);
    }

    @PostMapping
    public ResponseEntity<Producto> addProducto(@RequestBody Producto producto) {
        Producto nuevaProducto = productoService.guardarProducto(producto);
        return ResponseEntity.status(201).body(nuevaProducto);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteProducto(@PathVariable int id) {
        productoService.eliminarProducto(id);
        return ResponseEntity.noContent().build();
    }
}
