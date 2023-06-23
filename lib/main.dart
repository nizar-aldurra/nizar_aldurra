import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nizar_aldurra/BloC/authentication/authentication_bloc.dart';
import 'package:nizar_aldurra/BloC/like_post/like_post_bloc.dart';
import 'package:nizar_aldurra/BloC/user/user_bloc.dart';
import 'package:nizar_aldurra/BloC/update_info/update_info_bloc.dart';
import 'package:nizar_aldurra/screens/add_post_screen.dart';
import 'package:nizar_aldurra/screens/comments_screen.dart';
import 'package:nizar_aldurra/screens/home_screen.dart';
import 'package:nizar_aldurra/screens/login_screen.dart';
import 'package:nizar_aldurra/screens/register_screen.dart';
import 'package:nizar_aldurra/screens/start_app_screen.dart';

import 'BloC/login/login_bloc.dart';
import 'BloC/register/register_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(AuthenticationStatus.loading)
            ..loadCashedUser(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
        BlocProvider(
          create: (context) => LikePostBloc(),
        ),
        BlocProvider(
          create: (context) => UpdateInfoBloc(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const StartAppScreen(),
      routes: {
        StartAppScreen.routeName: (ctx) => const StartAppScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        RegisterScreen.routeName: (ctx) => RegisterScreen(),
        HomeScreen.routeName: (ctx) => const HomeScreen(),
        CommentsScreen.routeName: (ctx) => const CommentsScreen(),
        AddPostScreen.routeName: (ctx) => const AddPostScreen(),
      },
    );
  }
}
