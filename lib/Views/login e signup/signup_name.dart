import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Importa GetX
import 'package:image_picker/image_picker.dart';

import '../../services/auth_service.dart';

class SignUpNamePage extends StatefulWidget {
  final String email;
  final String password;

  const SignUpNamePage({super.key, required this.email, required this.password});

  @override
  SignUpNamePageState createState() => SignUpNamePageState();
}

class SignUpNamePageState extends State<SignUpNamePage> {
  final TextEditingController _nameController = TextEditingController();
  File? _image;
  bool _isSigningUp = false;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _signUp() async {
    // if (_image == null || _nameController.text.isEmpty) {
    //   Get.snackbar('Errore', 'Per favore, inserisci il tuo nome e seleziona un\'immagine',
    //       snackPosition: SnackPosition.BOTTOM);
    //   return;
    // }

    // if (!_isValidEmail(widget.email)) {
    //   Get.snackbar('Errore', 'Per favore, inserisci un\'email valida',
    //       snackPosition: SnackPosition.BOTTOM);
    //   return;
    // }

    setState(() {
      _isSigningUp = true;
    });

    final authService = Get.find<AuthService>(); // Usa GetX per ottenere il servizio di autenticazione
    try {
      await authService.signUpWithEmailAndPassword(
        widget.email,
        widget.password,
        _nameController.text,
        _image!,
      );

      if (mounted) {
        Get.offNamed('/login'); // Usa GetX per la navigazione
      }
    } catch (e) {
      if (mounted) {
        Get.snackbar('Errore durante la registrazione', '$e',
            snackPosition: SnackPosition.BOTTOM);
      }
    } finally {
      setState(() {
        _isSigningUp = false;
      });
    }
  }

  // bool _isValidEmail(String email) {
  //   final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  //   return emailRegExp.hasMatch(email);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Inserisci Nome e Immagine'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                backgroundColor: Colors.grey[800],
                child: _image == null
                    ? const Icon(
                  Icons.add_a_photo,
                  size: 50,
                  color: Colors.white,
                )
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Nome',
                labelStyle: const TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSigningUp ? null : _signUp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: _isSigningUp
                    ? const CircularProgressIndicator(
                  color: Colors.white,
                )
                    : const Text(
                  'Registrati',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
