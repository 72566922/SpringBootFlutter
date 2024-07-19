//SPRINGBOOTFLUTTER/jorgecolors/src/main/java/com/jorgecolors/jorgecolors/Empleados/EmpleadoService.java
package com.jorgecolors.jorgecolors.Empleados;

import org.springframework.stereotype.Service;
import org.springframework.dao.DataIntegrityViolationException;
import lombok.RequiredArgsConstructor;
import java.util.List;

@Service
@RequiredArgsConstructor
public class EmpleadoService {

    private final EmpleadoRepository empleadoRepo;

    public Empleado guardarEmpleado(Empleado empleado) {
        return empleadoRepo.save(empleado);
    }

    public void eliminarEmpleado(int id) {
        try {
            empleadoRepo.deleteById(id);
        } catch (DataIntegrityViolationException ex) {
            // Capturar la excepción y manejarla adecuadamente
            throw new IllegalStateException("Empleado se encuentra registrado en una venta. No se puede eliminar.");
        }
    }

    // Método para obtener todas las categorías, incluidas las deshabilitadas
    public List<Empleado> obtenerTodasEmpleado() {
        return empleadoRepo.findAll();
    }

    // Método para actualizar un empleado
    // EmpleadoService.java

    public Empleado actualizarEmpleado(int id, Empleado empleado) {
        Empleado empleadoExistente = empleadoRepo.findById(id)
                .orElseThrow(() -> new IllegalStateException("Empleado no encontrado con id: " + id));

        // Actualizar el estado a "deshabilitado"
        empleadoExistente.setHabilitar("deshabilitado");

        // Guardar el empleado actualizado en la base de datos
        return empleadoRepo.save(empleadoExistente);
    }

}
