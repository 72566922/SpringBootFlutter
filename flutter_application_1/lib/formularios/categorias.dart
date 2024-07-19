//SPRINGBOOTFLUTTER/flutter_application_1/lib/formularios/categorias.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Categoria {
  final int id;
  final String categoria;
  final String descripcion;
  final String habilitar;

  Categoria({
    required this.id,
    required this.categoria,
    required this.descripcion,
    required this.habilitar,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id: json['id_categoria'],
      categoria: json['categoria'],
      descripcion: json['description'],
      habilitar: json['habilitar'],
    );
  }

  Future<void> eliminar() async {
    final response = await http.delete(
      Uri.parse('http://192.168.1.44:8080/ferreteria/categorias/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 204) {
      // Eliminación exitosa, no es necesario hacer nada más en el frontend
    } else {
      throw Exception('Error al eliminar la categoría');
    }
  }
}

class CategoriasScreen extends StatefulWidget {
  @override
  _CategoriasScreenState createState() => _CategoriasScreenState();
}

class _CategoriasScreenState extends State<CategoriasScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  String _habilitado = 'HABILITADO'; // Valor por defecto

  late List<Categoria> _categorias;

  @override
  void initState() {
    super.initState();
    _categorias = [];
    _getCategorias();
  }

  Future<void> _getCategorias() async {
    final response = await http
        .get(Uri.parse('http://192.168.1.44:8080/ferreteria/categorias'));
    if (response.statusCode == 200) {
      final parsedResponse = json.decode(response.body);
      setState(() {
        _categorias = (parsedResponse as List)
            .map((categoria) => Categoria.fromJson(categoria))
            .toList();
      });
    } else {
      throw Exception('Error al cargar las categorías');
    }
  }

  Future<void> _addCategoria() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.post(
        Uri.parse('http://192.168.1.44:8080/ferreteria/categorias'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'categoria': _nombreController.text,
          'description': _descripcionController.text,
          'habilitar': _habilitado,
        }),
      );

      if (response.statusCode == 201) {
        // Actualiza la lista local de categorías
        await _getCategorias(); // Esperar a que se obtengan las categorías actualizadas

        setState(() {
          _nombreController.clear();
          _descripcionController.clear();
          _habilitado = 'HABILITADO'; // Restablecer el valor por defecto
        });
      } else {
        throw Exception('Error al añadir la categoría');
      }
    }
  }

  Future<void> _eliminarCategoria(Categoria categoria) async {
    try {
      await categoria.eliminar();
      setState(() {
        _categorias.remove(categoria);
      });
    } catch (e) {
      // Manejar errores de eliminación aquí
      print('Error al eliminar la categoría: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario Categorías'),
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
                      labelText: 'Nombre de categoría',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un nombre de categoría';
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
                    onPressed: _addCategoria,
                    child: Text('Añadir'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _categorias.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _categorias.length,
                      itemBuilder: (context, index) {
                        final categoria = _categorias[index];
                        return Card(
                            color: Color.fromARGB(255, 25, 67, 182),
                            child: ListTile(
                              title: Text(
                                categoria.categoria,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Descripción: ${categoria.descripcion}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    categoria.habilitar == 'HABILITADO'
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
                                onPressed: () => _eliminarCategoria(categoria),
                              ),
                            ));
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
