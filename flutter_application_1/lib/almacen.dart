//SPRINGBOOTFLUTTER/flutter_application_1/lib/almacen.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Categoria {
  final int id;
  final String categoria;
  final String habilitar;

  Categoria(
      {required this.id, required this.categoria, required this.habilitar});

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
        id: json['id'],
        categoria: json['categoria'],
        habilitar: json['habilitar']);
  }
}

class AlmacenScreen extends StatefulWidget {
  const AlmacenScreen({Key? key}) : super(key: key);

  @override
  _AlmacenScreenState createState() => _AlmacenScreenState();
}

class _AlmacenScreenState extends State<AlmacenScreen> {
  Categoria _categoriaSeleccionada =
      Categoria(id: 0, categoria: '', habilitar: '');
  late List<Categoria> _categorias = [];

  @override
  void initState() {
    super.initState();
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
            .where((categoria) =>
                categoria.habilitar ==
                'HABILITADO') // Filtrar solo las categorías habilitadas
            .toList();
        _categoriaSeleccionada = _categorias.isNotEmpty
            ? _categorias.first
            : Categoria(id: 1, categoria: '', habilitar: '');
      });
    } else {
      throw Exception('Error al cargar las categorías');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Almacen'),
      ),
      body: Center(
        child: DropdownButton<Categoria>(
          value: _categoriaSeleccionada,
          onChanged: (newValue) {
            setState(() {
              _categoriaSeleccionada = newValue!;
            });
          },
          items: _categorias
              .map<DropdownMenuItem<Categoria>>((Categoria categoria) {
            return DropdownMenuItem<Categoria>(
              value: categoria,
              child: Text(categoria.categoria),
            );
          }).toList(),
        ),
      ),
    );
  }
}
