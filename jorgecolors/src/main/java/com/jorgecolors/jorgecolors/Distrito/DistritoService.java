//SPRINGBOOTFLUTTER/jorgecolors/src/main/java/com/jorgecolors/jorgecolors/Distrito/DistritoService.java
package com.jorgecolors.jorgecolors.Distrito;

import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;
import java.util.List;

@Service
@RequiredArgsConstructor
public class DistritoService {
    
    private final DistritoRepository distritoRepo;

    public Distrito guardarDistrito(Distrito distrito) {
        return distritoRepo.save(distrito);
    }

    public void eliminarDistrito(int id) {
        distritoRepo.deleteById(id);
    }

    // Método para obtener todas las categorías, incluidas las deshabilitadas
    public List<Distrito> obtenerTodasDistrito() {
        return distritoRepo.findAll();
    }
}
