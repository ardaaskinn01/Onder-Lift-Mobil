import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Arka plan ve metin renklerini buradan değiştirebilirsiniz
        backgroundColor: Colors.white,
        cardColor: Colors.black,
      ),
      home: LoginScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
      },
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        // Header'ı gizlemek için bu kısmı kaldırabilirsiniz
      ),
      body: Center(
        child: Text(
          'Login Screen',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        // Header'ı gizlemek için bu kısmı kaldırabilirsiniz
      ),
      body: Center(
        child: Text(
          'Register Screen',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}