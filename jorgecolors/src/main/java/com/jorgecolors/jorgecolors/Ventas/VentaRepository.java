//SPRINGBOOTFLUTTER/jorgecolors/src/main/java/com/jorgecolors/jorgecolors/Ventas/VentaReposirory.java
package com.jorgecolors.jorgecolors.Ventas;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;



@Repository
public interface VentaRepository extends JpaRepository<Venta, Integer>{

}
