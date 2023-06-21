import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nizar_aldurra/BloC/update_profile/update_profile_bloc.dart';

import '../widgets/Nice_button.dart';
import '../widgets/nice_text_field.dart';

class UpdateProfile extends StatelessWidget {
  UpdateProfile(this.name, this.email, {super.key});

  UpdateProfileBloc _updateProfileBloc = UpdateProfileBloc();

  String name;

  String email;

  String? password;

  @override
  Widget build(BuildContext context) {
    _updateProfileBloc.add(UserNameChanged(name));
    _updateProfileBloc.add(EmailChanged(email));
    TextEditingController nameController = TextEditingController()..text=name;
    TextEditingController emailController = TextEditingController()..text=email;
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    return BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
      bloc: _updateProfileBloc,
      builder: (context, state) {
        if (state is UpdateProfileInitial) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Update Profile',
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NiceTextField(
                    hintText: 'enter the name',
                    labelText: 'User Name',
                    icon: Icons.person,
                    maxLines: 1,
                    keyboardType: TextInputType.name,
                    controller: nameController,
                    onChange: (value) {
                      _updateProfileBloc.add(UserNameChanged(value));
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
                      _updateProfileBloc.add(EmailChanged(value));
                    },
                  ),
                  NiceTextField(
                    hintText: 'enter the password',
                    labelText: 'Password',
                    icon: Icons.lock_outline,
                    maxLines: 1,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    controller: passwordController,
                    onChange: (value) {
                      _updateProfileBloc.add(PasswordChanged(value));
                    },
                  ),
                  NiceTextField(
                    hintText: 'confirm your password',
                    labelText: 'Confirm Password',
                    icon: Icons.lock_outline,
                    maxLines: 1,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    controller: confirmPasswordController,
                    onChange: (value) {
                      _updateProfileBloc.add(ConfirmPasswordChanged(value));
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  NiceButton(
                    text: 'Update',
                    onPress: () {
                      _updateProfileBloc.add(RegisterButtonPressed());
                      if (state is UpdateProfileSuccess) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        }else if(state is UpdateProfileLoading) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }else if(state is UpdateProfileSuccess) {
          Navigator.of(context).pop();
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
        else {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Update Profile',
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NiceTextField(
                    hintText: 'enter the name',
                    labelText: 'User Name',
                    icon: Icons.person,
                    maxLines: 1,
                    keyboardType: TextInputType.name,
                    controller: nameController,
                    onChange: (value) {
                      _updateProfileBloc.add(UserNameChanged(value));
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
                      _updateProfileBloc.add(EmailChanged(value));
                    },
                  ),
                  NiceTextField(
                    hintText: 'enter the password',
                    labelText: 'Password',
                    icon: Icons.lock_outline,
                    maxLines: 1,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    controller: passwordController,
                    onChange: (value) {
                      _updateProfileBloc.add(PasswordChanged(value));
                    },
                  ),
                  NiceTextField(
                    hintText: 'confirm your password',
                    labelText: 'Confirm Password',
                    icon: Icons.lock_outline,
                    maxLines: 1,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    controller: confirmPasswordController,
                    onChange: (value) {
                      _updateProfileBloc.add(ConfirmPasswordChanged(value));
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  NiceButton(
                    text: 'Update',
                    onPress: () {
                      _updateProfileBloc.add(RegisterButtonPressed());
                      if (state is UpdateProfileSuccess) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
