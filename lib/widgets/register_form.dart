import 'package:flutter/material.dart';
import 'package:nizar_aldurra/screens/login_screen.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _confirmedPassword = '';
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'email'),
              validator: (value) {
                if (value!.isEmpty) {
                  return "please enter the email";
                }
                return null;
              },
              onChanged: (value) {
                _email = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'password'),
              validator: (value) {
                if (value!.isEmpty) {
                  return "please enter the password";
                }
                return null;
              },
              onChanged: (value) {
                _password = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'confirm password'),
              validator: (value) {
                if (value!.isEmpty) {
                  return "please reenter the password";
                }
                return null;
              },
              onChanged: (value) {
                _confirmedPassword = value;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName);
                },
                child: const Text('have an account? Login here')),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print(_email);
                    print(_password);
                  }
                },
                child: const Text('Login'))
          ],
        ));
  }
}
