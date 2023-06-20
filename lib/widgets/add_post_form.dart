import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nizar_aldurra/BloC/add_post/add_post_bloc.dart';

class AddPostForm extends StatelessWidget {
  AddPostForm({super.key});

  final AddPostBloc _addPostBloc = AddPostBloc();

  final _formKey = GlobalKey<FormState>();

  String _title = '';

  String _description = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPostBloc, AddPostState>(
      bloc: _addPostBloc,
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'title',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter the title of the post";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _addPostBloc.add(TitlePostChanged(value));
                  },
                ),
                TextFormField(
                  maxLines: 4,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    labelText: 'post',
                    isDense: true,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please fill the post description";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _addPostBloc.add(BodyPostChanged(value));
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      _addPostBloc.add(AddPostButtonPressed());
                      if (_formKey.currentState!.validate()) {
                        if (state is! AddPostFailure) {
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: const Text('Add')),
              ],
            ),
          ),
        );
      },
    );
  }
}
