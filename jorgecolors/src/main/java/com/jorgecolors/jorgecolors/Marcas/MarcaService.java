package com.jorgecolors.jorgecolors.Marcas;

import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;
import java.util.List;

@Service
@RequiredArgsConstructor

public class MarcaService {
    

    private final MarcaRepository marcaRepo;

    public Marca guardarMarca(Marca marca) {
        return marcaRepo.save(marca);
    }

    public void eliminarMarca(int id) {
        marcaRepo.deleteById(id);
    }

    // Método para obtener todas las categorías, incluidas las deshabilitadas
    public List<Marca> obtenerTodasMarca() {
        return marcaRepo.findAll();
    }
}
