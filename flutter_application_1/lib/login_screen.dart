import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'menu.dart'; // Importa la nueva pantalla

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _message = '';

  Future<void> _login() async {
    try {
      final uri = Uri.http('192.168.1.44:8080', '/ferreteria/person/verify', {
        'email': _emailController.text,
        'username': _usernameController.text,
        'password': _passwordController.text,
      });

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _message = 'Login successful';
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MenuScreen(), // Cambia a MenuPage después del login
          ),
        );
      } else {
        setState(() {
          _message = 'Login failed';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'Error connecting to the server: $e';
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            Text(_message),
          ],
        ),
      ),
    );
  }
}
