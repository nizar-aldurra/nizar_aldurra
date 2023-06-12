import 'package:flutter/material.dart';
import 'package:nizar_aldurra/screens/add_post_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = 'home_Page';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        centerTitle: true,
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPostScreen.routeName);
            },
            icon: const Icon(Icons.add),
            label: const Text('New Post'),
            style: ButtonStyle(elevation: MaterialStateProperty.all(0)),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
