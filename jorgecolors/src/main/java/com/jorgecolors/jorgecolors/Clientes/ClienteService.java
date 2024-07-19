//SPRINGBOOTFLUTTER/jorgecolors/src/main/java/com/jorgecolors/jorgecolors/Clientes/ClienteService.java
package com.jorgecolors.jorgecolors.Clientes;

import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ClienteService {
    
    private final ClienteRepository clienteRepo;

    public Cliente guardarCliente(Cliente cliente) {
        return clienteRepo.save(cliente);
    }

    public void eliminarCliente(int id) {
        clienteRepo.deleteById(id);
    }

    // Método para obtener todas las categorías, incluidas las deshabilitadas
    public List<Cliente> obtenerTodasCliente() {
        return clienteRepo.findAll();
    }
}
