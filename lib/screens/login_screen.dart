import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nizar_aldurra/BloC/authentication/authentication_bloc.dart';
import 'package:nizar_aldurra/BloC/register/register_bloc.dart';
import 'package:nizar_aldurra/screens/home_screen.dart';
import 'package:nizar_aldurra/widgets/login_form.dart';
import 'package:nizar_aldurra/widgets/register_form.dart';
import '../BloC/login/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = 'login_screen';
  final LoginBloc _loginBloc = LoginBloc();
  final RegisterBloc _registerBloc = RegisterBloc();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Login(
      loginBloc: _loginBloc,
    );
  }
}

class Login extends StatelessWidget {
  const Login({
    super.key,
    required LoginBloc loginBloc,
  }) : _loginBloc = loginBloc;

  final LoginBloc _loginBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      bloc: _loginBloc,
      builder: (context, state) {
        if (state is LoginInitial) {
          return LoginForm(null,_loginBloc);
        } else if (state is LoginLoading) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (state is LoginSuccess) {
          context
              .read<AuthenticationBloc>()
              .add(AuthenticationLoggedIn(state.user));
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if(state is LoginFailure){
          return LoginForm(state.error,_loginBloc);
        }else{
          return const Scaffold(
              body: Center(child: Text('Server Error')));
        }
      },
    );
  }
}
