import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

import 'dart:convert';
import 'marca.dart';
import 'categorias.dart';

class Producto {
  final int id;
  final String color;
  final double p_costo; // Cambiado a int según tu estructura
  final double p_venta; // Cambiado a int según tu estructura
  final int id_marcas; // Cambiado a int según tu estructura
  final int id_categoria; // Cambiado a int según tu estructura
  final int cantidad;
  final String habilitar;

  Producto({
    required this.id,
    required this.color,
    required this.p_costo,
    required this.p_venta,
    required this.id_marcas,
    required this.id_categoria,
    required this.cantidad,
    required this.habilitar,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json[
          'id_productos'], // Debería ser 'id_empleado' si así está en el JSON
      color: json['color'],
      p_costo: json['p_costo'],
      p_venta: json['p_venta'],
      id_marcas: json['id_marcas'],
      id_categoria: json[
          'id_categoria'], // Debería ser 'id_distrito' si así está en el JSON
      cantidad: json['cantidad'], // Debería ser 'id_rol' si así está en el JSON
      habilitar: json['habilitar'],
    );
  }

  Future<void> eliminar() async {
    final response = await http.delete(
      Uri.parse('http://192.168.1.44:8080/ferreteria/productos/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Error al eliminar el empleado');
    }
  }
}

class ProductoScreen extends StatefulWidget {
  @override
  _ProductosScreenState createState() => _ProductosScreenState();
}

class _ProductosScreenState extends State<ProductoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _colorController = TextEditingController();
  final _pCostoController = TextEditingController();
  final _pVentaController = TextEditingController();
  int? _selectedMarcaId;
  int? _selectedCategoriaId;
  final _cantidadController = TextEditingController();
  String _habilitado = 'HABILITADO'; // Valor por defecto

  late List<Producto> _productos;
  late List<Marca> _marcas;
  late List<Categoria> _categorias;

  @override
  void initState() {
    super.initState();
    _productos = [];
    _marcas = [];
    _categorias = [];
    _getProductos();
    _getMarcas();
    _getCategorias();
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
      throw Exception('Error al cargar los marcas');
    }
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
      throw Exception('Error al cargar los categorias');
    }
  }

  String getMarcaName(int id) {
    final marca = _marcas.firstWhere((marca) => marca.id == id,
        orElse: () => Marca(id: id, marca: 'Desconocido', habilitar: 'No'));
    return marca.marca;
  }

  String getCategoriaName(int id) {
    final categoria = _categorias.firstWhere((categoria) => categoria.id == id,
        orElse: () => Categoria(
            id: id,
            categoria: 'Desconocido',
            descripcion: '',
            habilitar: 'No'));
    return categoria.categoria;
  }

  Future<void> _getProductos() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.44:8080/ferreteria/productos'));
    if (response.statusCode == 200) {
      final parsedResponse = json.decode(response.body);
      setState(() {
        _productos = (parsedResponse as List)
            .map((producto) => Producto.fromJson(producto))
            .toList();
      });
    } else {
      throw Exception('Error al cargar los productos');
    }
  }

  Future<void> _addProducto() async {
    try {
      // Antes de la solicitud HTTP POST, imprimir los valores actuales

      print('_selectedMarcaId: $_selectedMarcaId');
      print('_selectedCategoriaId: $_selectedCategoriaId');

      if (_formKey.currentState!.validate()) {
        final response = await http.post(
          Uri.parse('http://192.168.1.44:8080/ferreteria/productos'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'color': _colorController.text,
            'p_costo': _pCostoController.text,
            'p_venta': _pVentaController.text,
            'id_marcas': _selectedMarcaId,
            'id_categoria': _selectedCategoriaId,
            'cantidad': int.parse(_cantidadController.text),
            'habilitar': _habilitado,
          }),
        );

        if (response.statusCode == 201) {
          // Éxito al añadir el empleado
          await _getProductos(); // Actualizar la lista de empleados
          setState(() {
            // Limpiar los campos del formulario después de agregar
            _colorController.clear();
            _pCostoController.clear();
            _pVentaController.clear();
            _selectedMarcaId = null;
            _selectedCategoriaId = null;
            _cantidadController.clear();
            _habilitado = 'HABILITADO'; // Valor por defecto
          });
        } else {
          // Error al añadir el empleado (código de estado diferente de 201)
          throw Exception(
              'Error al añadir el producto: ${response.statusCode}');
        }
      }
    } catch (e) {
      // Captura de errores generales durante la solicitud HTTP
      print('Error al añadir el producto: $e');
      // Aquí puedes agregar más detalles según sea necesario para depuración
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error al añadir el producto'),
            content: Text(
                'Ocurrió un problema al intentar añadir el producto. Por favor, inténtalo de nuevo más tarde.'),
            actions: <Widget>[
              TextButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _eliminarProducto(Producto producto) async {
    try {
      await producto.eliminar();
      setState(() {
        _productos.remove(producto);
      });
    } catch (e) {
      print('Error al eliminar el producto: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario Productos'),
        backgroundColor: Color.fromARGB(255, 7, 36, 168),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _colorController,
                  decoration: InputDecoration(
                    labelText: 'Color',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el color';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _pCostoController,
                  decoration: InputDecoration(
                    labelText: 'Precio Costo',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la edad';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _pVentaController,
                  decoration: InputDecoration(
                    labelText: 'Precio Venta',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la edad';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<int>(
                  value: _selectedMarcaId,
                  hint: Text('Selecciona una marca'),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: _marcas.map((Marca marca) {
                    return DropdownMenuItem(
                      value: marca.id,
                      child: Text(marca.marca),
                    );
                  }).toList(),
                  onChanged: (int? value) {
                    setState(() {
                      _selectedMarcaId = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor selecciona un marca';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<int>(
                  value: _selectedCategoriaId,
                  hint: Text('Selecciona una categoria'),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: _categorias.map((Categoria categoria) {
                    return DropdownMenuItem(
                      value: categoria.id,
                      child: Text(categoria.categoria),
                    );
                  }).toList(),
                  onChanged: (int? value) {
                    setState(() {
                      _selectedCategoriaId = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor selecciona una categoria';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _cantidadController,
                  decoration: InputDecoration(
                    labelText: 'Cantidad',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la edad';
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
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _addProducto,
                  child: Text('Añadir Producto'),
                ),
                SizedBox(height: 20),
                _productos.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _productos.length,
                        itemBuilder: (context, index) {
                          final producto = _productos[index];
                          return Card(
                            color: Color.fromARGB(255, 25, 67, 182),
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              title: Text(
                                '${producto.color} ${producto.id_marcas} ${producto.id_categoria}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'color: ${producto.color}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    'p_costo: ${producto.p_costo.toString()}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    'p_venta: ${producto.p_venta.toString()}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    'Marca: ${getMarcaName(producto.id_marcas)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    'Categoria: ${getCategoriaName(producto.id_categoria)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    'Cantidad: ${producto.cantidad.toString()}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    'Estado: ${producto.habilitar}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  // Puedes agregar más campos según tus necesidades
                                ],
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Confirmación'),
                                        content: Text(
                                          '¿Estás seguro de eliminar a ${producto.color} ${producto.id_marcas} ${producto.id_categoria}?',
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('Cancelar'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text('Eliminar'),
                                            onPressed: () {
                                              _eliminarProducto(producto);
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
