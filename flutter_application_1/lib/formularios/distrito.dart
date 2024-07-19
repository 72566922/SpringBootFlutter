//SPRINGBOOTFLUTTER/flutter_application_1/lib/Formularios/distrito.java
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Distrito {
  final int id;
  final String distrito;
  final String habilitar;

  Distrito({
    required this.id,
    required this.distrito,
    required this.habilitar,
  });

  factory Distrito.fromJson(Map<String, dynamic> json) {
    return Distrito(
      id: json['id_distrito'],
      distrito: json['distrito'],
      habilitar: json['habilitar'],
    );
  }

  Future<void> eliminar() async {
    final response = await http.delete(
      Uri.parse('http://192.168.1.44:8080/ferreteria/distrito/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 204) {
      // Eliminación exitosa, no es necesario hacer nada más en el frontend
    } else {
      throw Exception('Error al eliminar la distrito');
    }
  }
}

class DistritoScreen extends StatefulWidget {
  @override
  _DistritoScreenState createState() => _DistritoScreenState();
}

class _DistritoScreenState extends State<DistritoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  String _habilitado = 'HABILITADO'; // Valor por defecto

  late List<Distrito> _distritos;

  @override
  void initState() {
    super.initState();
    _distritos = [];
    _getDistritos();
  }

  Future<void> _getDistritos() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.44:8080/ferreteria/distrito'));
    if (response.statusCode == 200) {
      final parsedResponse = json.decode(response.body);
      setState(() {
        _distritos = (parsedResponse as List)
            .map((distrito) => Distrito.fromJson(distrito))
            .toList();
      });
    } else {
      throw Exception('Error al cargar las distritos');
    }
  }

  Future<void> _addDistrito() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.post(
        Uri.parse('http://192.168.1.44:8080/ferreteria/distrito'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'distrito': _nombreController.text,
          'habilitar': _habilitado,
        }),
      );

      if (response.statusCode == 201) {
        // Actualiza la lista local de distritos
        await _getDistritos(); // Esperar a que se obtengan los distritos actualizados

        setState(() {
          _nombreController.clear();
          _habilitado = 'HABILITADO'; // Restablecer el valor por defecto
        });
      } else {
        throw Exception('Error al añadir el distrito');
      }
    }
  }

  Future<void> _eliminarDistrito(Distrito distrito) async {
    try {
      await distrito.eliminar();
      setState(() {
        _distritos.remove(distrito);
      });
    } catch (e) {
      print('Error al eliminar la distrito: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario Distritos'),
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
                      labelText: 'Nombre de distrito',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un nombre de distrito';
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
                    onPressed: _addDistrito,
                    child: Text('Añadir'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _distritos.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _distritos.length,
                      itemBuilder: (context, index) {
                        final distrito = _distritos[index];
                        return Card(
                          color: Color.fromARGB(255, 25, 67, 182),
                          child: ListTile(
                            title: Text(
                              distrito.distrito,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              distrito.habilitar == 'HABILITADO'
                                  ? 'Habilitado'
                                  : 'Deshabilitado',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _eliminarDistrito(distrito),
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
