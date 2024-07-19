import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:convert';
import 'distrito.dart';
import 'rol.dart';

class Empleado {
  final int id;
  final String dni;
  final String nombre;
  final String apellido;
  final String direccion;
  final int idDistrito;
  final int idRol;
  final String telefono;
  final String celular;
  final String correo;
  final int edad;
  final String sexo;
  final String habilitar;

  Empleado({
    required this.id,
    required this.dni,
    required this.nombre,
    required this.apellido,
    required this.direccion,
    required this.idDistrito,
    required this.idRol,
    required this.telefono,
    required this.celular,
    required this.correo,
    required this.edad,
    required this.sexo,
    required this.habilitar,
  });

  factory Empleado.fromJson(Map<String, dynamic> json) {
    return Empleado(
      id: json['id_empleado'],
      dni: json['dni'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      direccion: json['direccion'],
      idDistrito: json['id_distrito'],
      idRol: json['id_rol'],
      telefono: json['telefono'],
      celular: json['celular'],
      correo: json['correo'],
      edad: json['edad'],
      sexo: json['sexo'],
      habilitar: json['habilitar'],
    );
  }

  Future<void> eliminar() async {
    try {
      final response = await http.delete(
        Uri.parse('http://192.168.1.44:8080/ferreteria/empleados/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode != 204) {
        throw Exception('Error al eliminar el empleado');
      }
    } catch (e) {
      print('Error al eliminar el empleado: $e');
      // Aquí manejas la actualización del estado a "deshabilitado"
      try {
        await _actualizarEstadoEmpleado();
      } catch (e) {
        print('Error al actualizar el estado del empleado: $e');
        throw Exception('Error al eliminar el empleado y actualizar el estado');
      }
    }
  }

  Future<void> _actualizarEstadoEmpleado() async {
    final response = await http.put(
      Uri.parse('http://192.168.1.44:8080/ferreteria/empleados/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'habilitar': 'deshabilitado',
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el estado del empleado');
    }
  }
}

class EmpleadoScreen extends StatefulWidget {
  @override
  _EmpleadoScreenState createState() => _EmpleadoScreenState();
}

class _EmpleadoScreenState extends State<EmpleadoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dniController = TextEditingController();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _direccionController = TextEditingController();
  int? _selectedDistritoId;
  int? _selectedRolId;
  final _telefonoController = TextEditingController();
  final _celularController = TextEditingController();
  final _correoController = TextEditingController();
  final _edadController = TextEditingController();

  String _sexo = 'Masculino'; // Valor por defecto
  String _habilitado = 'HABILITADO'; // Valor por defecto

  late List<Empleado> _empleados;
  late List<Distrito> _distritos;
  late List<Rol> _roles;

  @override
  void initState() {
    super.initState();
    _empleados = [];
    _distritos = [];
    _roles = [];
    _getEmpleados();
    _getDistritos();
    _getRoles();
  }

  Future<void> _getEmpleados() async {
    try {
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
    } catch (e) {
      print('Error al cargar los empleados: $e');
      // Aquí podrías mostrar un AlertDialog con el error
    }
  }

  Future<void> _getDistritos() async {
    try {
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
    } catch (e) {
      print('Error al cargar los distritos: $e');
      // Aquí podrías mostrar un AlertDialog con el error
    }
  }

  Future<void> _getRoles() async {
    try {
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
    } catch (e) {
      print('Error al cargar los roles: $e');
      // Aquí podrías mostrar un AlertDialog con el error
    }
  }

  String getDistritoName(int id) {
    final distrito = _distritos.firstWhere((distrito) => distrito.id == id,
        orElse: () =>
            Distrito(id: id, distrito: 'Desconocido', habilitar: 'No'));
    return distrito.distrito;
  }

  String getRolName(int id) {
    final rol = _roles.firstWhere((rol) => rol.id == id,
        orElse: () => Rol(
            id: id,
            rol: 'Desconocido',
            descripcion: '',
            salario: 0,
            habilitar: 'No'));
    return rol.rol;
  }

  Future<void> _addEmpleado() async {
    try {
      if (_formKey.currentState!.validate()) {
        final response = await http.post(
          Uri.parse('http://192.168.1.44:8080/ferreteria/empleados'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'dni': _dniController.text,
            'nombre': _nombreController.text,
            'apellido': _apellidoController.text,
            'direccion': _direccionController.text,
            'id_distrito': _selectedDistritoId,
            'id_rol': _selectedRolId,
            'telefono': _telefonoController.text,
            'celular': _celularController.text,
            'correo': _correoController.text,
            'edad': int.parse(_edadController.text),
            'sexo': _sexo,
            'habilitar': _habilitado,
          }),
        );

        if (response.statusCode == 201) {
          await _getEmpleados();
          setState(() {
            _dniController.clear();
            _nombreController.clear();
            _apellidoController.clear();
            _direccionController.clear();
            _selectedDistritoId = null;
            _selectedRolId = null;
            _telefonoController.clear();
            _celularController.clear();
            _correoController.clear();
            _edadController.clear();
            _sexo = 'Masculino';
            _habilitado = 'HABILITADO';
          });
        } else {
          throw Exception(
              'Error al añadir el empleado: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Error al añadir el empleado: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error al añadir el empleado'),
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

  Future<void> _eliminarEmpleado(Empleado empleado) async {
    try {
      await empleado.eliminar();
      setState(() {
        _empleados.remove(empleado);
      });
    } catch (e) {
      print('Error al eliminar el empleado: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error al eliminar el empleado'),
            content: Text(
                'Ocurrió un problema al intentar eliminar el empleado. Por favor, inténtalo de nuevo más tarde.'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario Empleados'),
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
                  decoration: InputDecoration(
                    labelText: 'Distrito',
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
                DropdownButtonFormField<int>(
                  value: _selectedRolId,
                  items: _roles.map((rol) {
                    return DropdownMenuItem<int>(
                      value: rol.id,
                      child: Text(rol.rol),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Rol',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _selectedRolId = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor seleccione un rol';
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
                TextFormField(
                  controller: _edadController,
                  decoration: InputDecoration(
                    labelText: 'Edad',
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
                  onPressed: _addEmpleado,
                  child: Text('Añadir Empleado'),
                ),
                SizedBox(height: 32.0),
                Text(
                  'Empleados',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                _empleados.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: _empleados.length,
                        itemBuilder: (context, index) {
                          final empleado = _empleados[index];

                          return Card(
                            color: Color.fromARGB(255, 25, 67, 182),
                            elevation: 4,
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Text(
                                empleado.nombre,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white, // Color del texto blanco
                                ),
                              ),
                              subtitle: Text(
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Colors.white, // Color del texto blanco
                                  ),
                                  'DNI: ${empleado.dni}, Distrito: ${getDistritoName(empleado.idDistrito)}, Rol: ${getRolName(empleado.idRol)}'),
                              trailing: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  _eliminarEmpleado(empleado);
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
