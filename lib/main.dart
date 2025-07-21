import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? error;

  void _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.9/login.php'), // Use your PC IP if on real device
        body: {
          'username': username,
          'password': password,
        },
      );

      final data = jsonDecode(response.body);

      if (data['status'] == 'success') {
        setState(() {
          error = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful!')),
        );
        // TODO: Navigate to next screen if you want
      } else {
        setState(() {
          error = 'Invalid username or password';
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error connecting to server';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Page')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            if (error != null) ...[
              SizedBox(height: 10),
              Text(error!, style: TextStyle(color: Colors.red)),
            ],
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            )
          ],
        ),
      ),
    );
  }
}
