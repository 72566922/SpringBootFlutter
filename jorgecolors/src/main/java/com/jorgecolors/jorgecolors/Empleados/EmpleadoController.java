//SPRINGBOOTFLUTTER/jorgecolors/src/main/java/com/jorgecolors/jorgecolors/Empleados/EmpleadoController.java
package com.jorgecolors.jorgecolors.Empleados;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import lombok.RequiredArgsConstructor;
import java.util.List;

@RestController
@RequestMapping("/empleados")
@RequiredArgsConstructor
public class EmpleadoController {

    private final EmpleadoService empleadoService;

    @GetMapping
    public ResponseEntity<List<Empleado>> getEmpleado() {
        List<Empleado> empleados = empleadoService.obtenerTodasEmpleado();
        return ResponseEntity.ok(empleados);
    }

    @PostMapping
    public ResponseEntity<Empleado> addEmpleado(@RequestBody Empleado empleado) {
        Empleado nuevaEmpleado = empleadoService.guardarEmpleado(empleado);
        return ResponseEntity.status(201).body(nuevaEmpleado);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteEmpleado(@PathVariable int id) {
        empleadoService.eliminarEmpleado(id);
        return ResponseEntity.noContent().build();
    }


    @PutMapping("/{id}")
    public ResponseEntity<Empleado> updateEmpleado(
            @PathVariable int id,
            @RequestBody Empleado empleado) {
        Empleado empleadoActualizado = empleadoService.actualizarEmpleado(id, empleado);
        return ResponseEntity.ok(empleadoActualizado);
    }

}
