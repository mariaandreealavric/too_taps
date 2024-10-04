import 'package:flutter/material.dart';
import 'package:too_taps/Views/Auth/signup_name.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrazione'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Per favore, inserisci una email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Per favore, inserisci una password';
                  }
                  if (value.length < 6) {
                    return 'La password deve essere lunga almeno 6 caratteri';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(labelText: 'Conferma Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Per favore, conferma la tua password';
                  }
                  if (value != _passwordController.text) {
                    return 'Le password non coincidono';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    String email = _emailController.text;
                    String password = _passwordController.text;

                    // Navigazione alla pagina per inserire il nome
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpNamePage(
                          email: email,
                          password: password,
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Avanti'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
