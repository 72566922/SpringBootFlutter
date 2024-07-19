import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Marca {
  final int id;
  final String marca;
  final String habilitar;

  Marca({
    required this.id,
    required this.marca,
    required this.habilitar,
  });

  factory Marca.fromJson(Map<String, dynamic> json) {
    return Marca(
      id: json['id_marcas'],
      marca: json['marca'],
      habilitar: json['habilitar'],
    );
  }

  Future<void> eliminar() async {
    final response = await http.delete(
      Uri.parse('http://192.168.1.44:8080/ferreteria/marcas/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 204) {
      // Eliminación exitosa, no es necesario hacer nada más en el frontend
    } else {
      throw Exception('Error al eliminar la marca');
    }
  }
}

class MarcasScreen extends StatefulWidget {
  @override
  _MarcasScreenState createState() => _MarcasScreenState();
}

class _MarcasScreenState extends State<MarcasScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  String _habilitado = 'HABILITADO'; // Valor por defecto

  late List<Marca> _marcas;

  @override
  void initState() {
    super.initState();
    _marcas = [];
    _getMarcas();
  }

  Future<void> _getMarcas() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.44:8080/ferreteria/marcas'));
    if (response.statusCode == 200) {
      final parsedResponse = json.decode(response.body);
      setState(() {
        _marcas = (parsedResponse as List)
            .map((marca) => Marca.fromJson(marca))
            .toList();
      });
    } else {
      throw Exception('Error al cargar las marcas');
    }
  }

  Future<void> _addMarca() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.post(
        Uri.parse('http://192.168.1.44:8080/ferreteria/marcas'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'marca': _nombreController.text,
          'habilitar': _habilitado,
        }),
      );

      if (response.statusCode == 201) {
        // Actualiza la lista local de marcas
        await _getMarcas(); // Esperar a que se obtengan las marcas actualizadas

        setState(() {
          _nombreController.clear();
          _habilitado = 'HABILITADO'; // Restablecer el valor por defecto
        });
      } else {
        throw Exception('Error al añadir la marca');
      }
    }
  }

  Future<void> _eliminarMarca(Marca marca) async {
    try {
      await marca.eliminar();
      setState(() {
        _marcas.remove(marca);
      });
    } catch (e) {
      print('Error al eliminar la marca: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario Marcas'),
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
                      labelText: 'Nombre de marca',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un nombre de marca';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    value: _habilitado,
                    decoration: InputDecoration(
                      labelText: 'Estado',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    items: ['HABILITADO', 'DESHABILITADO']
                        .map((label) => DropdownMenuItem(
                              child: Text(label),
                              value: label,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _habilitado = value!;
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 15, 39, 173),
                      foregroundColor: Colors.white,
                      shadowColor: Color.fromARGB(255, 30, 105, 218),
                      elevation: 5,
                    ),
                    onPressed: _addMarca,
                    child: Text('Añadir'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Divider(),
            Expanded(
              child: _marcas.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _marcas.length,
                      itemBuilder: (context, index) {
                        final marca = _marcas[index];
                        return Card(
                          color: Color.fromARGB(255, 25, 67, 182),
                          elevation: 4,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(
                              marca.marca,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white, // Color del texto blanco
                              ),
                            ),
                            subtitle: Text(
                              marca.habilitar == 'HABILITADO'
                                  ? 'Habilitado'
                                  : 'Deshabilitado',
                              style: TextStyle(
                                  color:
                                      Colors.white), // Color del texto blanco
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _eliminarMarca(marca),
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

