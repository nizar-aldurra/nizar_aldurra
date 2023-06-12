import 'package:flutter/material.dart';
import 'package:nizar_aldurra/screens/add_post_screen.dart';
import 'package:nizar_aldurra/screens/home_screen.dart';
import 'package:nizar_aldurra/screens/login_screen.dart';
import 'package:nizar_aldurra/screens/register_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: LoginScreen(),
      ),
      routes: {
        LoginScreen.routeName: (ctx) => const LoginScreen(),
        RegisterScreen.routeName: (ctx) => const RegisterScreen(),
        HomeScreen.routeName: (ctx) => const HomeScreen(),
        AddPostScreen.routeName : (ctx) => const AddPostScreen(),
      },
    );
  }
}
