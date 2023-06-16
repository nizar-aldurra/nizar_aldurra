import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nizar_aldurra/BloC/authentication/authentication_bloc.dart';
import 'package:nizar_aldurra/BloC/authentication/authentication_bloc.dart';
import 'package:nizar_aldurra/screens/register_screen.dart';
import '../BloC/login/login_bloc.dart';
import 'Nice_button.dart';
import 'nice_text_field.dart';

class LoginForm extends StatelessWidget {
  LoginForm(this.loginBloc, {super.key});

  LoginBloc loginBloc;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NiceTextField(
              hintText: 'enter the email address',
              labelText: 'Email',
              icon: Icons.email_outlined,
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              onChange: (value) {
                loginBloc.add(EmailChanged(value));
              },
            ),
            NiceTextField(
              hintText: 'enter the password',
              labelText: 'Password',
              icon: Icons.password,
              keyboardType: TextInputType.text,
              controller: passwordController,
              obscureText: true,
              onChange: (value) {
                loginBloc.add(PasswordChanged(value));
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(RegisterScreen.routeName);
                },
                child: const Text('Don\'t have an account? Register here')),
            const SizedBox(
              height: 15,
            ),
            NiceButton(
              text: 'Login',
              onPress: () {
                loginBloc.add(LoginButtonPressed());
              },
            ),
          ],
        ),
      ),
    );
  }
}



