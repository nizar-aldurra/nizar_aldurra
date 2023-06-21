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

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode myFocus = FocusNode();

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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NiceTextField(
                  hintText: 'enter the username',
                  labelText: 'User Name',
                  icon: Icons.person,
                  maxLines: 1,
                  keyboardType: TextInputType.name,
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please insert your name';
                    } else {
                      return null;
                    }
                  },
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
                    _registerBloc.add(EmailChanged(value));
                  },
                ),
                NiceTextField(
                  hintText: 'enter the password',
                  labelText: 'Password',
                  icon: Icons.lock_outline,
                  maxLines: 1,
                  keyboardType: TextInputType.emailAddress,
                  controller: passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    } else if (RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                        .hasMatch(value)) {
                      return 'Enter valid password';
                    } else {
                      return null;
                    }
                  },
                  onChange: (value) {
                    _registerBloc.add(PasswordChanged(value));
                  },
                ),
                NiceTextField(
                  hintText: 'confirm your password',
                  labelText: 'Confirm Password',
                  icon: Icons.lock_outline,
                  maxLines: 1,
                  keyboardType: TextInputType.emailAddress,
                  controller: confirmPasswordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Re-Enter The Password';
                    } else if (passwordController.value.text !=
                        confirmPasswordController.value.text) {
                      return 'Password must be same as above';
                    } else {
                      return null;
                    }
                  },
                  onChange: (value) {
                    _registerBloc.add(ConfirmPasswordChanged(value));
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Have an account? Login here')),
                const SizedBox(
                  height: 15,
                ),
                NiceButton(
                  text: 'Register',
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      _registerBloc.add(RegisterButtonPressed());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
