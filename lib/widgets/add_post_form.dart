import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nizar_aldurra/BloC/add_post/add_post_bloc.dart';

class AddPostForm extends StatelessWidget {
  AddPostForm({super.key});

  final AddPostBloc _addPostBloc = AddPostBloc();

  final _formKey = GlobalKey<FormState>();
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddPostBloc, AddPostState>(
      bloc: _addPostBloc,
      listener: (context, state) {
        if (state is AddPostLoaded){
          Navigator.of(context).pop();
        }
        if(state is AddPostFailure){
          errorMessage=state.error;
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              errorMessage == null
                  ? const SizedBox()
                  : Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
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
                    if (_formKey.currentState!.validate()) {
                      _addPostBloc.add(AddPostButtonPressed());
                    }
                  },
                  child: const Text('Add')),
            ],
          ),
        ),
      ),
    );
  }
}
