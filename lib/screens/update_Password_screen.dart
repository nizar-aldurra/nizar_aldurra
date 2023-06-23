import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nizar_aldurra/BloC/update_password/update_password_bloc.dart';

import '../widgets/Nice_button.dart';
import '../widgets/nice_text_field.dart';

class UpdatePasswordScreen extends StatefulWidget {
  UpdatePasswordScreen({super.key});
String password='';
String confPassword='';
String currentPassword='';
  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  UpdatePasswordBloc updatePasswordBloc = UpdatePasswordBloc();
  String? errorMessage;

  onchange() {
    setState(() {
      errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    updatePasswordBloc.add(CurrentPasswordChanged(widget.currentPassword));
    updatePasswordBloc.add(NewPasswordChanged(widget.password));
    return BlocListener<UpdatePasswordBloc, UpdatePasswordState>(
      bloc: updatePasswordBloc,
      listener: (context, state) {
        if (state is UpdatePasswordInitial) {
        } else if (state is UpdatePasswordLoading) {
        } else if (state is UpdatePasswordSuccess) {
          Navigator.of(context).pop();
        } else if (state is UpdatePasswordFailure) {
          setState(() {
            errorMessage=state.error;
          });
        }
      },
      child: UpdateForm(context),
    );
  }

  Widget UpdateForm(BuildContext context) {
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
        child: SingleChildScrollView(
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
                  onChange: (value) {
                    widget.currentPassword=value;
                    updatePasswordBloc.add(CurrentPasswordChanged(value));
                    onchange();
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
                    widget.password=value;
                    updatePasswordBloc.add(NewPasswordChanged(value));
                    onchange();
                  },
                ),
                NiceTextField(
                  hintText: 'Enter Re-Enter the new password',
                  labelText: 'Confirm Password',
                  icon: Icons.lock_outline,
                  maxLines: 1,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Re-Enter The Password';
                    } else if (widget.password !=
                        widget.confPassword) {
                      return 'Password must be same as above';
                    } else {
                      return null;
                    }
                  },
                  onChange: (value) {
                    widget.confPassword=value;
                    onchange();
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                NiceButton(
                  text: 'Update',
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      print('${widget.password} ${widget.currentPassword} ${widget.confPassword}');
                      // updatePasswordBloc.add(CurrentPasswordChanged(widget.currentPassword));
                      // updatePasswordBloc.add(NewPasswordChanged(widget.password));
                      updatePasswordBloc.add(UpdateButtonPressed());
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
