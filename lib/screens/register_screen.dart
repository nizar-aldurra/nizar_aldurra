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
    String? errorMessage;
    return BlocListener<RegisterBloc, RegisterState>(
      bloc: _registerBloc,
      listener: (context, state) {
        if (state is RegisterInitial) {
        } else if (state is RegisterLoading) {
        } else if (state is RegisterSuccess) {
          context.read<AuthenticationBloc>().add(
                AuthenticationSignedUp(state.user));
              Navigator.of(context).pop();
        } else if(state is RegisterFailure){
          errorMessage=state.error;
        }
      },
      child: RegisterForm(errorMessage,_registerBloc),
    );
  }
}
