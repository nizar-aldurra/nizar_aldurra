import 'package:flutter/material.dart';
import 'package:nizar_aldurra/widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = 'register_screen';
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: const Center(
          child: SingleChildScrollView(
            child: RegisterForm(),
          ),
        ),
      ),
    );
  }
}
