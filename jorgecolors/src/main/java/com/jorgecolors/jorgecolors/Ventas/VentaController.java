//SPRINGBOOTFLUTTER/jorgecolors/src/main/java/com/jorgecolors/jorgecolors/Ventas/VentaController.java
package com.jorgecolors.jorgecolors.Ventas;


import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import lombok.RequiredArgsConstructor;
import java.util.List;

@RestController
@RequestMapping("/ventas")
@RequiredArgsConstructor
public class VentaController {
    
    private final VentaService ventaService;

    @GetMapping
    public ResponseEntity<List<Venta>> getVenta() {
        List<Venta> venta = ventaService.obtenerTodasVenta();
        return ResponseEntity.ok(venta);
    }

    @PostMapping
    public ResponseEntity<Venta> addVenta(@RequestBody Venta venta) {
        Venta nuevaVenta= ventaService.guardarVenta(venta);
        return ResponseEntity.status(201).body(nuevaVenta);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteVenta(@PathVariable int id) {
        ventaService.eliminarVenta(id);
        return ResponseEntity.noContent().build();
    }
}
