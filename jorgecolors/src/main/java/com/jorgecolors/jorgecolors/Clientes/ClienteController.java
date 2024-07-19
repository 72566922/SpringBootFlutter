//SPRINGBOOTFLUTTER/jorgecolors/src/main/java/com/jorgecolors/jorgecolors/Clientes/ClienteController.java
package com.jorgecolors.jorgecolors.Clientes;


import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import lombok.RequiredArgsConstructor;
import java.util.List;

@RestController
@RequestMapping("/clientes")
@RequiredArgsConstructor
public class ClienteController {
    private final ClienteService clienteService;

    @GetMapping
    public ResponseEntity<List<Cliente>> getCliente() {
        List<Cliente> cliente = clienteService.obtenerTodasCliente();
        return ResponseEntity.ok(cliente);
    }

    @PostMapping
    public ResponseEntity<Cliente> addCliente(@RequestBody Cliente cliente) {
        Cliente nuevaCliente = clienteService.guardarCliente(cliente);
        return ResponseEntity.status(201).body(nuevaCliente);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteCliente(@PathVariable int id) {
        clienteService.eliminarCliente(id);
        return ResponseEntity.noContent().build();
    }
}
