import 'package:flutter/material.dart';
import 'package:nizar_aldurra/screens/login_screen.dart';

import '../BloC/register/register_bloc.dart';
import 'Nice_button.dart';
import 'nice_text_field.dart';

class RegisterForm extends StatelessWidget {
  RegisterBloc _registerBloc;
  RegisterForm(this._registerBloc, {super.key});

  final _formKey = GlobalKey<FormState>();

  String _name = '';

  String _email = '';

  String _password = '';

  String _confirmedPassword = '';

  TextEditingController nameController=TextEditingController();

  TextEditingController emailController=TextEditingController();

  TextEditingController passwordController=TextEditingController();

  TextEditingController confirmPasswordController=TextEditingController();

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
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NiceTextField(
              hintText: 'enter the username',
              labelText: 'User Name',
              icon: Icons.abc,
              maxLines: 1,
              keyboardType: TextInputType.name,
              controller: nameController,
              onChange: (value) {
                _registerBloc.add(UserNameChanged(value));
              },
            ),
            NiceTextField(
              hintText: 'enter the email address',
              labelText: 'Email',
              icon: Icons.email_outlined,
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              onChange: (value) {
                _registerBloc.add(EmailChanged(value));
              },
            ),
            NiceTextField(
              hintText: 'enter the password',
              labelText: 'Password',
              icon: Icons.password_outlined,
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              controller: passwordController,
              obscureText: true,
              onChange: (value) {
                _registerBloc.add(PasswordChanged(value));
              },
            ),
            NiceTextField(
              hintText: 'confirm your password',
              labelText: 'Confirm Password',
              icon: Icons.password_outlined,
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              controller: confirmPasswordController,
              obscureText: true,
              onChange: (value) {
                _registerBloc.add(ConfirmPasswordChanged(value));
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pop();
                },
                child: const Text('Don\'t have an account? Register here')),
            const SizedBox(
              height: 15,
            ),
            NiceButton(
              text: 'Register',
              onPress: () {
                _registerBloc.add(RegisterButtonPressed());
              },
            ),
          ],
        ),
      ),
    );
  }
}
