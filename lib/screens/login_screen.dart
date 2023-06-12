import 'package:flutter/material.dart';
import 'package:nizar_aldurra/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = 'login_screen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: const Center(
          child: SingleChildScrollView(
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}
