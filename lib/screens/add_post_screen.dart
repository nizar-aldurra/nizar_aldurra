import 'package:flutter/material.dart';
import 'package:nizar_aldurra/widgets/add_post_form.dart';

class AddPostScreen extends StatelessWidget {
  static const routeName = 'add_post_screen';

  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add post',
        ),
        centerTitle: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: const SingleChildScrollView(
          child: AddPostForm(),
        ),
      ),
    );
  }
}
