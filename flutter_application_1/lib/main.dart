import 'package:flutter/material.dart';
import 'menu.dart'; // Importa la nueva pantalla de menú
import 'login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor:
            Color.fromARGB(255, 190, 193, 197), // Fondo del formulario en gris
      ),
      home: LoginScreen(), // Cambia a MenuScreen como la página inicial
    );
  }
}
