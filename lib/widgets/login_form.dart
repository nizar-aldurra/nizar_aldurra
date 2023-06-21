import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nizar_aldurra/BloC/authentication/authentication_bloc.dart';
import 'package:nizar_aldurra/BloC/authentication/authentication_bloc.dart';
import 'package:nizar_aldurra/screens/register_screen.dart';
import '../BloC/login/login_bloc.dart';
import 'Nice_button.dart';
import 'nice_text_field.dart';

class LoginForm extends StatefulWidget {
  LoginForm(this.errorMessage, this.loginBloc, {super.key});

  LoginBloc loginBloc;
  String? errorMessage;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  onchange() {
    setState(() {
      widget.errorMessage = null;
    });
  }

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
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.errorMessage == null
                  ? const SizedBox()
                  : Text(
                      widget.errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 18),
                    ),
              NiceTextField(
                hintText: 'enter the email address',
                labelText: 'Email',
                icon: Icons.email_outlined,
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please insert your email.";
                  } else if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                    return "please insert a valide email format.";
                  } else {
                    return null;
                  }
                },
                onChange: (value) {
                  onchange();
                  widget.loginBloc.add(EmailChanged(value));
                },
              ),
              NiceTextField(
                hintText: 'enter the password',
                labelText: 'Password',
                icon: Icons.lock_outline,
                keyboardType: TextInputType.text,
                controller: passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  } else {
                    return null;
                  }
                },
                onChange: (value) {
                  onchange();
                  widget.loginBloc.add(PasswordChanged(value));
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextButton(
                  onPressed: () {
                    onchange();
                    Navigator.of(context).pushNamed(RegisterScreen.routeName);
                  },
                  child: const Text('Don\'t have an account? Register here')),
              const SizedBox(
                height: 15,
              ),
              NiceButton(
                text: 'Login',
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    widget.loginBloc.add(LoginButtonPressed());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
