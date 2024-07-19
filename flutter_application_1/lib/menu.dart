import 'package:flutter/material.dart';
import 'formularios/categorias.dart'; // Asegúrate de tener la ruta correcta al archivo almacen.dart
import 'formularios/rol.dart';
import 'formularios/marca.dart';
import 'formularios/distrito.dart';
import 'formularios/empleados.dart';
import 'formularios/productos.dart';
import 'formularios/clientes.dart';
import 'formularios/ventas.dart';
import 'almacen.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          int crossAxisCount = 2;

          if (maxWidth > 740) {
            crossAxisCount = 3;
          }

          if (maxWidth > 920) {
            crossAxisCount = 4;
          }

          double childAspectRatio = 1.3;

          if (maxWidth > 740) {
            childAspectRatio = 1.5;
          }

          if (maxWidth > 920) {
            childAspectRatio = 1.8;
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: GridView(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: childAspectRatio,
              ),
              children: [
                _buildMenuItem(
                    context, Icons.category, 'Categorías', CategoriasScreen()),
                _buildMenuItem(context, Icons.account_box, 'Rol', RolScreen()),
                _buildMenuItem(context, Icons.label, 'Marca', MarcasScreen()),
                _buildMenuItem(
                    context, Icons.location_on, 'Distrito', DistritoScreen()),
                _buildMenuItem(
                    context, Icons.work, 'Empleados', EmpleadoScreen()),
                _buildMenuItem(context, Icons.shopping_cart, 'Productos',
                    ProductoScreen()),
                _buildMenuItem(
                    context, Icons.people, 'Clientes', ClienteScreen()),
                _buildMenuItem(
                    context, Icons.attach_money, 'Ventas', VentaScreen()),
                _buildMenuItem(context, Icons.logout, 'Cerrar Sesión'),
                _buildMenuItem(context, Icons.exit_to_app, 'Salir'),
              ]
                  .map((widget) => Container(
                        padding: EdgeInsets.all(10),
                        child: FractionallySizedBox(
                          widthFactor: crossAxisCount == 2 ? 0.9 : 0.7,
                          child: Container(
                            constraints: BoxConstraints(
                              minWidth: 20,
                              maxWidth: 120,
                            ),
                            child: widget,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String label,
      [Widget? destination]) {
    return InkWell(
      onTap: () {
        if (destination != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Navegar a $label'),
              duration: Duration(seconds: 1),
            ),
          );
        }
      },
      child: Card(
        elevation: 2,
        color: Color.fromARGB(255, 13, 39, 185),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 25,
                color: Colors.white,
              ),
              SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
