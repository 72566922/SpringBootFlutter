package com.jorgecolors.jorgecolors.Productos;


import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ProductoService {
    
    private final ProductoRepository productoRepo;

    public Producto guardarProducto(Producto producto) {
        return productoRepo.save(producto);
    }

    public void eliminarProducto(int id) {
        productoRepo.deleteById(id);
    }

    // Método para obtener todas las categorías, incluidas las deshabilitadas
    public List<Producto> obtenerTodasProducto() {
        return productoRepo.findAll();
    }
}
