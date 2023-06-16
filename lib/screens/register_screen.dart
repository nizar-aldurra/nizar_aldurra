import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nizar_aldurra/BloC/register/register_bloc.dart';
import 'package:nizar_aldurra/screens/home_screen.dart';
import 'package:nizar_aldurra/widgets/register_form.dart';

import '../BloC/authentication/authentication_bloc.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = 'register_screen';
  final RegisterBloc _registerBloc = RegisterBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      bloc: _registerBloc,
      builder: (context, state) {
        if (state is RegisterInitial) {
          return RegisterForm(_registerBloc);
        } else if (state is RegisterLoading) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (state is RegisterSuccess) {
          context.read<AuthenticationBloc>().add(
            AuthenticationSignedUp(state.user),);
          return HomeScreen();

        } else {
          return RegisterForm(_registerBloc);
        }
      },
    );
  }
}
