import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nizar_aldurra/BloC/add_post/add_post_bloc.dart';
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
        child: SingleChildScrollView(
          child: BlocProvider(
            create: (context) => AddPostBloc(),
            child: AddPostForm(),
          ),
        ),
      ),
    );
  }
}
