import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nizar_aldurra/BloC/update_password/update_password_bloc.dart';

import '../widgets/Nice_button.dart';
import '../widgets/nice_text_field.dart';

class UpdatePasswordScreen extends StatefulWidget {
  UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  UpdatePasswordBloc updatePasswordBloc = UpdatePasswordBloc();
  final _formKey = GlobalKey<FormState>();
  String? errorMessage;

  onchange() {
    setState(() {
      errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdatePasswordBloc, UpdatePasswordState>(
      bloc: updatePasswordBloc,
      builder: (context, state) {
        if (state is UpdatePasswordInitial) {
          return UpdateForm(state, context);
        } else if (state is UpdatePasswordLoading) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (state is UpdatePasswordSuccess) {
          Navigator.of(context).pop();
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (state is UpdatePasswordFailure) {
          return UpdateForm(state, context);
        } else {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget UpdateForm(UpdatePasswordState state, BuildContext context) {
    TextEditingController currentController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Password',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              errorMessage == null
                  ? const SizedBox()
                  : Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 18),
                    ),
              NiceTextField(
                autofocus: true,
                hintText: 'Enter the current password',
                labelText: 'Current Password',
                icon: Icons.lock_outline,
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                controller: currentController,
                onChange: (value) {
                  onchange();
                  updatePasswordBloc.add(CurrentPasswordChanged(value));
                },
              ),
              const SizedBox(
                height: 30,
              ),
              NiceTextField(
                hintText: 'Enter the new password',
                labelText: 'New Password',
                icon: Icons.lock_outline,
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                controller: passwordController,
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
                  onchange();
                  updatePasswordBloc.add(NewPasswordChanged(value));
                },
              ),
              NiceTextField(
                hintText: 'Enter Re-Enter the new password',
                labelText: 'Confirm Password',
                icon: Icons.lock_outline,
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                controller: confirmController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Re-Enter The Password';
                  } else if (passwordController.value.text !=
                      confirmController.value.text) {
                    return 'Password must be same as above';
                  } else {
                    return null;
                  }
                },
                onChange: (value) {
                  onchange();
                  updatePasswordBloc.add(ConfirmPasswordChanged(value));
                },
              ),
              const SizedBox(
                height: 15,
              ),
              NiceButton(
                text: 'Update',
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    updatePasswordBloc.add(UpdateButtonPressed());
                    if (state is UpdatePasswordSuccess) {
                      Navigator.of(context).pop();
                    }
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
