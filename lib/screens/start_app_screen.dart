import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nizar_aldurra/BloC/authentication/authentication_bloc.dart';
import 'package:nizar_aldurra/screens/home_screen.dart';
import 'package:nizar_aldurra/screens/login_screen.dart';

class StartAppScreen extends StatelessWidget {
  static const routeName = 'start_app_screen';

  const StartAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationStatus>(
        builder: (context, state) {
          if (state == AuthenticationStatus.loading) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          return state == AuthenticationStatus.unauthenticated
              ? LoginScreen()
              : HomeScreen();
        },
    );
  }
}
