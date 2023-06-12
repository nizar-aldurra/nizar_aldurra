import 'package:flutter/material.dart';
import 'package:nizar_aldurra/screens/home_screen.dart';
import 'package:nizar_aldurra/screens/register_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'email',
              ),
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
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(RegisterScreen.routeName);
                },
                child: const Text('Don\'t have an account? Register here')),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print(_email);
                    print(_password);
                    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                  }
                },
                child: const Text('Login'))
          ],
        ));
  }
}
