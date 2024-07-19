//SPRINGBOOTFLUTTER/jorgecolors/src/main/java/com/jorgecolors/jorgecolors/Categoria/CategoriaService.java
package com.jorgecolors.jorgecolors.Categoria;

import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CategoriaService {
    
    private final CategoriaRepository categoriaRepo;

    public Categoria guardarCategoria(Categoria categoria) {
        return categoriaRepo.save(categoria);
    }

    public void eliminarCategoria(int id) {
        categoriaRepo.deleteById(id);
    }

    // Método para obtener todas las categorías, incluidas las deshabilitadas
    public List<Categoria> obtenerTodasCategorias() {
        return categoriaRepo.findAll();
    }
}

