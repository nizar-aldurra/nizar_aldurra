import 'package:flutter/material.dart';

class AddPostForm extends StatefulWidget {
  const AddPostForm({super.key});

  @override
  State<AddPostForm> createState() => _AddPostFormState();
}

class _AddPostFormState extends State<AddPostForm> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
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
                _title = value;
              },
            ),
            TextFormField(
              maxLines: 5,
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
                _description = value;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Add')),
          ],
        ));
  }
}
