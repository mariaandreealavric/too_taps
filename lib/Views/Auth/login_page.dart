import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/auth_service.dart'; // Importa GetX

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Metodo di login
  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      final authService = Get.find<AuthService>(); // Usa GetX per ottenere il servizio di autenticazione
      try {
        await authService.signInWithEmailAndPassword(
          emailController.text,
          passwordController.text,
        );
        if (mounted) {
          Get.offNamed('/imageList'); // Usa GetX per la navigazione
        }
      } catch (e) {
        if (mounted) {
          Get.snackbar('Login Failed', 'Login failed: $e', // Usa GetX per mostrare Snackbar
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: validateEmail,
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: validatePassword,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: login,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
