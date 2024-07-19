import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:convert';
import 'productos.dart';
import 'clientes.dart';
import 'empleados.dart';

class ProductoInfo {
  final String color;
  final double pVenta;

  ProductoInfo({required this.color, required this.pVenta});
}

class Venta {
  final int id;
  final int id_cliente;
  final int id_empleado; // Cambiado a int según tu estructura
  final int id_productos; // Cambiado a int según tu estructura
  final int unidades;
  final double total;

  Venta({
    required this.id,
    required this.id_cliente,
    required this.id_empleado,
    required this.id_productos,
    required this.unidades,
    required this.total,
  });

  factory Venta.fromJson(Map<String, dynamic> json) {
    return Venta(
      id: json['id_venta'],
      id_cliente: json['id_cliente'],
      id_empleado: json['id_empleado'],
      id_productos: json['id_productos'],
      unidades: json['unidades'],
      total: json['total'].toDouble(),
    );
  }

  Future<void> eliminar() async {
    final response = await http.delete(
      Uri.parse('http://192.168.1.44:8080/ferreteria/ventas/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Error al eliminar la venta');
    }
  }
}

class VentaScreen extends StatefulWidget {
  @override
  _VentaScreenState createState() => _VentaScreenState();
}

class _VentaScreenState extends State<VentaScreen> {
  final _formKey = GlobalKey<FormState>();
  int? _selectedClienteId;
  int? _selectedEmpleadoId;
  int? _selectedProductosId;
  final _pVentasController = TextEditingController();
  final _unidadesController = TextEditingController();
  final _totalController = TextEditingController();

  late List<Venta> _ventas;
  late List<Cliente> _clientes;
  late List<Empleado> _empleados;
  late List<Producto> _productos;

  @override
  void initState() {
    super.initState();
    _ventas = [];
    _clientes = [];
    _empleados = [];
    _productos = [];
    _getVentas();
    _getClientes();
    _getEmpleados();
    _getProductos();
  }

  Future<void> _getClientes() async {
    final response = await http
        .get(Uri.parse('http://192.168.1.44:8080/ferreteria/clientes'));
    if (response.statusCode == 200) {
      final parsedResponse = json.decode(response.body);
      setState(() {
        _clientes = (parsedResponse as List)
            .map((cliente) => Cliente.fromJson(cliente))
            .toList();
      });
    } else {
      throw Exception('Error al cargar los clientes');
    }
  }

  Future<void> _getProductos() async {
    final response = await http
        .get(Uri.parse('http://192.168.1.44:8080/ferreteria/productos'));
    if (response.statusCode == 200) {
      final parsedResponse = json.decode(response.body);
      setState(() {
        _productos = (parsedResponse as List)
            .map((producto) => Producto.fromJson(producto))
            .toList();
      });
    } else {
      throw Exception('Error al cargar los Productos');
    }
  }

  Future<void> _getEmpleados() async {
    final response = await http
        .get(Uri.parse('http://192.168.1.44:8080/ferreteria/empleados'));
    if (response.statusCode == 200) {
      final parsedResponse = json.decode(response.body);
      setState(() {
        _empleados = (parsedResponse as List)
            .map((empleado) => Empleado.fromJson(empleado))
            .toList();
      });
    } else {
      throw Exception('Error al cargar los empleados');
    }
  }

  ProductoInfo getProductoInfo(int id) {
    final producto = _productos.firstWhere(
      (producto) => producto.id == id,
      orElse: () => Producto(
        id: id,
        color: 'Desconocido',
        p_costo: 0,
        p_venta: 0,
        id_marcas: 0,
        id_categoria: 0,
        cantidad: 0,
        habilitar: 'No',
      ),
    );

    return ProductoInfo(color: producto.color, pVenta: producto.p_venta);
  }

  String getClienteName(int id) {
    final cliente = _clientes.firstWhere((cliente) => cliente.id == id,
        orElse: () => Cliente(
            id: id,
            dni: 'Desconocido',
            nombre: 'No',
            apellido: 'No',
            direccion: 'No',
            idDistrito: 0,
            telefono: 'No',
            celular: 'No',
            correo: 'No',
            sexo: 'No',
            habilitar: 'No'));
    return cliente.nombre;
  }

  String getEmpleadoName(int id) {
    final empleado = _empleados.firstWhere((empleado) => empleado.id == id,
        orElse: () => Empleado(
            id: id,
            dni: 'Desconocido',
            nombre: 'No',
            apellido: 'No',
            direccion: 'No',
            idDistrito: 0,
            idRol: 0,
            telefono: 'No',
            celular: 'No',
            correo: 'No',
            edad: 0,
            sexo: 'No',
            habilitar: 'No'));
    return empleado.nombre;
  }

  Future<void> _getVentas() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.44:8080/ferreteria/ventas'));
    if (response.statusCode == 200) {
      final parsedResponse = json.decode(response.body);
      print(
          'Received ventas JSON: $parsedResponse'); // Añadir impresión para depuración

      setState(() {
        _ventas = (parsedResponse as List).map((ventaJson) {
          print(
              'Processing venta JSON: $ventaJson'); // Añadir impresión para depuración
          return Venta.fromJson(ventaJson);
        }).toList();
      });
    } else {
      throw Exception('Error al cargar los ventas');
    }
  }

  Future<void> _addVenta() async {
    try {
      // Antes de la solicitud HTTP POST, imprimir los valores actuales
      print('_selectedClienteId: $_selectedClienteId');
      print('_selectedEmpleadoId: $_selectedEmpleadoId');
      print('_selectedProductosId: $_selectedProductosId');

      if (_formKey.currentState!.validate()) {
        // Calcular el total como pVenta * unidades
        double total = double.parse(_pVentasController.text) *
            int.parse(_unidadesController.text);

        // Actualizar _totalController con el total calculado
        _totalController.text = total.toStringAsFixed(2);

        final response = await http.post(
          Uri.parse('http://192.168.1.44:8080/ferreteria/ventas'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'id_cliente': _selectedClienteId,
            'id_empleado': _selectedEmpleadoId,
            'id_productos': _selectedProductosId,
            'unidades': int.parse(_unidadesController.text),
            'total': total, // Usar el total calculado
          }),
        );

        if (response.statusCode == 201) {
          // Éxito al añadir la venta
          await _getVentas(); // Actualizar la lista de ventas
          setState(() {
            // Limpiar los campos del formulario después de agregar
            _selectedClienteId = null;
            _selectedEmpleadoId = null;
            _selectedProductosId = null;
            _unidadesController.clear();
            _totalController.clear(); // Valor por defecto
          });
        } else {
          // Error al añadir la venta (código de estado diferente de 201)
          throw Exception('Error al añadir la venta: ${response.statusCode}');
        }
      }
    } catch (e) {
      // Captura de errores generales durante la solicitud HTTP
      print('Error al añadir la venta: $e');
      // Aquí puedes agregar más detalles según sea necesario para depuración
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error al añadir la venta'),
            content: Text(
                'Ocurrió un problema al intentar añadir la venta. Por favor, inténtalo de nuevo más tarde.'),
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

  Future<void> _eliminarVenta(Venta venta) async {
    try {
      await venta.eliminar();
      setState(() {
        _ventas.remove(venta);
      });
    } catch (e) {
      print('Error al eliminar la venta: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario Ventas'),
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
                DropdownButtonFormField<int>(
                  value: _selectedClienteId,
                  hint: Text('Selecciona un Cliente'),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: _clientes.map((Cliente cliente) {
                    return DropdownMenuItem(
                      value: cliente.id,
                      child: Text(cliente.nombre),
                    );
                  }).toList(),
                  onChanged: (int? value) {
                    setState(() {
                      _selectedClienteId = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor selecciona un Cliente';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<int>(
                  value: _selectedEmpleadoId,
                  hint: Text('Selecciona un Empleado'),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: _empleados.map((Empleado empleado) {
                    return DropdownMenuItem(
                      value: empleado.id,
                      child: Text(empleado.nombre),
                    );
                  }).toList(),
                  onChanged: (int? value) {
                    setState(() {
                      _selectedEmpleadoId = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor selecciona un Empleado';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<int>(
                  value: _selectedProductosId,
                  hint: Text('Selecciona un Producto'),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: _productos.map((Producto producto) {
                    return DropdownMenuItem(
                      value: producto.id,
                      child: Text(producto.color),
                    );
                  }).toList(),
                  onChanged: (int? value) {
                    setState(() {
                      _selectedProductosId = value;
                      _pVentasController.text =
                          getProductoInfo(value!).pVenta.toString();

                      // Calcular el total al cambiar el producto seleccionado
                      if (_unidadesController.text.isNotEmpty) {
                        double total = double.parse(_pVentasController.text) *
                            int.parse(_unidadesController.text);
                        _totalController.text = total.toStringAsFixed(2);
                      }
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor selecciona un Producto';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _pVentasController,
                  decoration: InputDecoration(
                    labelText: 'Precio de Venta',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  readOnly: true,
                ),
                TextFormField(
                  controller: _unidadesController,
                  decoration: InputDecoration(
                    labelText: 'Unidades',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese las unidades';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _totalController,
                  decoration: InputDecoration(
                    labelText: 'Total de Venta',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  readOnly: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _addVenta,
                  child: Text('Añadir Venta'),
                ),
                SizedBox(height: 20),
                _ventas.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _ventas.length,
                        itemBuilder: (context, index) {
                          final venta = _ventas[index];
                          return Card(
                            color: Color.fromARGB(255, 25, 67, 182),
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              title: Text(
                                '${venta.id} - ${getClienteName(venta.id_cliente)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Empleado: ${getEmpleadoName(venta.id_empleado)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    'Producto: ${getProductoInfo(venta.id_productos).color}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    'Unidades: ${venta.unidades.toString()}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    'Total: ${venta.total.toString()}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
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
                                          '¿Estás seguro de eliminar la venta?',
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
                                              _eliminarVenta(venta);
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
