//SPRINGBOOTFLUTTER/flutter_application_1/lib/Formularios/rol.java
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Rol {
  final int id;
  final String rol;
  final String descripcion;
  final double salario;
  final String habilitar;

  Rol({
    required this.id,
    required this.rol,
    required this.descripcion,
    required this.salario,
    required this.habilitar,
  });

  factory Rol.fromJson(Map<String, dynamic> json) {
    return Rol(
      id: json['id_rol'],
      rol: json['rol'],
      descripcion: json['descripcion'],
      salario: json['salario'],
      habilitar: json['habilitar'],
    );
  }

  Future<void> eliminar() async {
    final response = await http.delete(
      Uri.parse('http://192.168.1.44:8080/ferreteria/rol/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Error al eliminar el rol');
    }
  }
}

class RolScreen extends StatefulWidget {
  @override
  _RolScreenState createState() => _RolScreenState();
}

class _RolScreenState extends State<RolScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _salarioController = TextEditingController();
  String _habilitado = 'HABILITADO'; // Valor por defecto

  late List<Rol> _roles;

  @override
  void initState() {
    super.initState();
    _roles = [];
    _getRoles();
  }

  Future<void> _getRoles() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.44:8080/ferreteria/rol'));
    if (response.statusCode == 200) {
      final parsedResponse = json.decode(response.body);
      setState(() {
        _roles =
            (parsedResponse as List).map((rol) => Rol.fromJson(rol)).toList();
      });
    } else {
      throw Exception('Error al cargar los roles');
    }
  }

  Future<void> _addRol() async {
    try {
      if (_formKey.currentState!.validate()) {
        final response = await http.post(
          Uri.parse('http://192.168.1.44:8080/ferreteria/rol'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'rol': _nombreController.text,
            'descripcion': _descripcionController.text,
            'salario': double.parse(_salarioController.text),
            'habilitar': _habilitado,
          }),
        );

        if (response.statusCode == 201) {
          // Actualiza la lista local de roles
          await _getRoles(); // Esperar a que se obtengan los roles actualizados

          setState(() {
            _nombreController.clear();
            _descripcionController.clear();
            _salarioController.clear();
            _habilitado = 'HABILITADO'; // Restablecer el valor por defecto
          });
        } else {
          throw Exception('Error al añadir el rol: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Error al añadir el rol: $e');
      // Mostrar un diálogo o mensaje de error al usuario según tus necesidades.
    }
  }

  Future<void> _eliminarRol(Rol rol) async {
    try {
      await rol.eliminar();
      setState(() {
        _roles.remove(rol);
      });
    } catch (e) {
      print('Error al eliminar el rol: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario Roles'),
        backgroundColor: Color.fromARGB(255, 7, 36, 168),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Lógica para cerrar sesión
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nombreController,
                    decoration: InputDecoration(
                      labelText: 'Nombre del rol',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un nombre del rol';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descripcionController,
                    decoration: InputDecoration(
                      labelText: 'Descripción',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese una descripción';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _salarioController,
                    decoration: InputDecoration(
                      labelText: 'Salario',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un salario';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Por favor ingrese un número válido';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Text('Habilitado:'),
                      Radio<String>(
                        value: 'HABILITADO',
                        groupValue: _habilitado,
                        onChanged: (value) {
                          setState(() {
                            _habilitado = value!;
                          });
                        },
                      ),
                      Text('Sí'),
                      Radio<String>(
                        value: 'DESHABILITADO',
                        groupValue: _habilitado,
                        onChanged: (value) {
                          setState(() {
                            _habilitado = value!;
                          });
                        },
                      ),
                      Text('No'),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: _addRol,
                    child: Text('Añadir'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _roles.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _roles.length,
                      itemBuilder: (context, index) {
                        final rol = _roles[index];
                        return Card(
                          color: Color.fromARGB(255, 25, 67, 182),
                          child: ListTile(
                            title: Text(
                              rol.rol,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Descripción: ${rol.descripcion}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  'Salario: ${rol.salario}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  rol.habilitar == 'HABILITADO'
                                      ? 'Habilitado'
                                      : 'Deshabilitado',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _eliminarRol(rol),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
