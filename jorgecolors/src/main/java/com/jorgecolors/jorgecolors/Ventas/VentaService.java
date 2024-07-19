//SPRINGBOOTFLUTTER/jorgecolors/src/main/java/com/jorgecolors/jorgecolors/Ventas/VentaService.java
package com.jorgecolors.jorgecolors.Ventas;


import org.springframework.stereotype.Service;


import lombok.RequiredArgsConstructor;
import java.util.List;

@Service
@RequiredArgsConstructor
public class VentaService {
    
    private final VentaRepository ventaRepo;

    public Venta guardarVenta(Venta venta) {
        return ventaRepo.save(venta);
    }

    public void eliminarVenta(int id) {
        ventaRepo.deleteById(id);
    }

    // Método para obtener todas las categorías, incluidas las deshabilitadas
    public List<Venta> obtenerTodasVenta() {
        return ventaRepo.findAll();
    }
}
