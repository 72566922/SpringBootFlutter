import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:convert';
import 'distrito.dart';

class Cliente {
  final int id;
  final String dni;
  final String nombre;
  final String apellido;
  final String direccion;
  final int idDistrito; // Cambiado a int según tu estructura
  final String telefono;
  final String celular;
  final String correo;
  final String sexo;
  final String habilitar;

  Cliente({
    required this.id,
    required this.dni,
    required this.nombre,
    required this.apellido,
    required this.direccion,
    required this.idDistrito,
    required this.telefono,
    required this.celular,
    required this.correo,
    required this.sexo,
    required this.habilitar,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id_cliente'],
      dni: json['dni'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      direccion: json['direccion'],
      idDistrito: json['id_distrito'],
      telefono: json['telefono'],
      celular: json['celular'],
      correo: json['correo'],
      sexo: json['sexo'],
      habilitar: json['habilitar'],
    );
  }

  Future<void> eliminar() async {
    final response = await http.delete(
      Uri.parse('http://192.168.1.44:8080/ferreteria/clientes/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Error al eliminar el Cliente');
    }
  }
}

class ClienteScreen extends StatefulWidget {
  @override
  _ClienteScreenState createState() => _ClienteScreenState();
}

class _ClienteScreenState extends State<ClienteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dniController = TextEditingController();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _direccionController = TextEditingController();
  int? _selectedDistritoId;
  final _telefonoController = TextEditingController();
  final _celularController = TextEditingController();
  final _correoController = TextEditingController();
  String _sexo = 'Masculino'; // Valor por defecto
  String _habilitado = 'HABILITADO'; // Valor por defecto

  late List<Cliente> _clientes;
  late List<Distrito> _distritos;

  @override
  void initState() {
    super.initState();
    _clientes = [];
    _distritos = [];
    _getClientes();
    _getDistritos();
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
      throw Exception('Error al cargar los Cliente');
    }
  }

  Future<void> _getDistritos() async {
    final response = await http
        .get(Uri.parse('http://192.168.1.44:8080/ferreteria/distrito'));
    if (response.statusCode == 200) {
      final parsedResponse = json.decode(response.body);
      setState(() {
        _distritos = (parsedResponse as List)
            .map((distrito) => Distrito.fromJson(distrito))
            .toList();
      });
    } else {
      throw Exception('Error al cargar los distritos');
    }
  }

  String getDistritoName(int id) {
    final distrito = _distritos.firstWhere((distrito) => distrito.id == id,
        orElse: () =>
            Distrito(id: id, distrito: 'Desconocido', habilitar: 'No'));
    return distrito.distrito;
  }

  Future<void> _addCliente() async {
    try {
      if (_formKey.currentState!.validate()) {
        final response = await http.post(
          Uri.parse('http://192.168.1.44:8080/ferreteria/clientes'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'dni': _dniController.text,
            'nombre': _nombreController.text,
            'apellido': _apellidoController.text,
            'direccion': _direccionController.text,
            'id_distrito': _selectedDistritoId,
            'telefono': _telefonoController.text,
            'celular': _celularController.text,
            'correo': _correoController.text,
            'sexo': _sexo,
            'habilitar': _habilitado,
          }),
        );

        if (response.statusCode == 201) {
          await _getClientes();
          setState(() {
            _dniController.clear();
            _nombreController.clear();
            _apellidoController.clear();
            _direccionController.clear();
            _selectedDistritoId = null;
            _telefonoController.clear();
            _celularController.clear();
            _correoController.clear();
            _sexo = 'Masculino';
            _habilitado = 'HABILITADO';
          });
        } else {
          throw Exception('Error al añadir el Cliente: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Error al añadir el Cliente: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error al añadir el Cliente'),
            content: Text(
                'Ocurrió un problema al intentar añadir el empleado. Por favor, inténtalo de nuevo más tarde.'),
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

  Future<void> _eliminarCliente(Cliente cliente) async {
    try {
      await cliente.eliminar();
      setState(() {
        _clientes.remove(cliente);
      });
    } catch (e) {
      print('Error al eliminar el empleado: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario Clientes'),
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
                  controller: _dniController,
                  decoration: InputDecoration(
                    labelText: 'DNI',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  maxLength: 8,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el DNI';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _nombreController,
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el nombre';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _apellidoController,
                  decoration: InputDecoration(
                    labelText: 'Apellido',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el apellido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _direccionController,
                  decoration: InputDecoration(
                    labelText: 'Dirección',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la dirección';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<int>(
                  value: _selectedDistritoId,
                  items: _distritos.map((distrito) {
                    return DropdownMenuItem<int>(
                      value: distrito.id,
                      child: Text(distrito.distrito),
                    );
                  }).toList(),
                  hint: Text('Seleccione un Distrito'),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _selectedDistritoId = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor seleccione un distrito';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _telefonoController,
                  decoration: InputDecoration(
                    labelText: 'Teléfono',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  maxLength: 7,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el teléfono';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _celularController,
                  decoration: InputDecoration(
                    labelText: 'Celular',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  maxLength: 9,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el celular';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _correoController,
                  decoration: InputDecoration(
                    labelText: 'Correo',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el correo';
                    }
                    return null;
                  },
                ),
                Row(
                  children: <Widget>[
                    Text('Sexo:'),
                    SizedBox(width: 16.0),
                    Row(
                      children: <Widget>[
                        Radio<String>(
                          value: 'Masculino',
                          groupValue: _sexo,
                          onChanged: (value) {
                            setState(() {
                              _sexo = value!;
                            });
                          },
                        ),
                        Text('Masculino'),
                        Radio<String>(
                          value: 'Femenino',
                          groupValue: _sexo,
                          onChanged: (value) {
                            setState(() {
                              _sexo = value!;
                            });
                          },
                        ),
                        Text('Femenino'),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('Habilitado:'),
                    SizedBox(width: 16.0),
                    Row(
                      children: <Widget>[
                        Radio<String>(
                          value: 'HABILITADO',
                          groupValue: _habilitado,
                          onChanged: (value) {
                            setState(() {
                              _habilitado = value!;
                            });
                          },
                        ),
                        Text('Habilitado'),
                        Radio<String>(
                          value: 'INHABILITADO',
                          groupValue: _habilitado,
                          onChanged: (value) {
                            setState(() {
                              _habilitado = value!;
                            });
                          },
                        ),
                        Text('Inhabilitado'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _addCliente,
                  child: Text('Añadir Empleado'),
                ),
                SizedBox(height: 32.0),
                Text(
                  'Clientes',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _clientes.length,
                  itemBuilder: (context, index) {
                    final cliente = _clientes[index];
                    return Card(
                      color: Color.fromARGB(255, 25, 67, 182),
                      child: ListTile(
                        title: Text(
                          cliente.nombre,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'DNI: ${cliente.dni}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              'Distrito: ${getDistritoName(cliente.idDistrito)}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _eliminarCliente(cliente);
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
