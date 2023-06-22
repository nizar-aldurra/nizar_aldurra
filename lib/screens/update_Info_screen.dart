import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nizar_aldurra/BloC/update_info/update_info_bloc.dart';

import '../widgets/Nice_button.dart';
import '../widgets/nice_text_field.dart';

class UpdateInfoScreen extends StatefulWidget {
  UpdateInfoScreen(this.name, this.email, {super.key});

  String name;

  String email;

  @override
  State<UpdateInfoScreen> createState() => _UpdateInfoScreenState();
}

class _UpdateInfoScreenState extends State<UpdateInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  String? errorMessage;
  UpdateInfoBloc _updateProfileBloc = UpdateInfoBloc();

  String? password;

  onchange() {
    setState(() {
      errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    _updateProfileBloc.add(UserNameChanged(widget.name));
    _updateProfileBloc.add(EmailChanged(widget.email));
    return BlocBuilder<UpdateInfoBloc, UpdateInfoState>(
      bloc: _updateProfileBloc,
      builder: (context, state) {
        if (state is UpdateInfoInitial) {
          return UpdateForm(widget.name, widget.email, state, context);
        } else if (state is UpdateInfoLoading) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (state is UpdateInfoSuccess) {
          Navigator.of(context).pop();
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (state is UpdateInfoFailure) {
          return UpdateForm(widget.name, widget.email, state, context);
        } else {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget UpdateForm(
      String name, String email, UpdateInfoState state, BuildContext context) {
    TextEditingController nameController = TextEditingController()
      ..text = widget.name;
    TextEditingController emailController = TextEditingController()
      ..text = widget.email;
    if (state is UpdateInfoFailure) {
      errorMessage = state.error.toString();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Information',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              errorMessage == null
                  ? const SizedBox()
                  : Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 18),
                    ),
              NiceTextField(
                hintText: 'Enter the name',
                labelText: 'User Name',
                icon: Icons.person,
                maxLines: 1,
                autofocus: true,
                keyboardType: TextInputType.name,
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please insert your name';
                  } else {
                    return null;
                  }
                },
                onChange: (value) {
                  onchange();
                  print(value);
                  _updateProfileBloc.add(UserNameChanged(value));
                },
              ),
              NiceTextField(
                hintText: 'Enter the email address',
                labelText: 'Email',
                icon: Icons.email_outlined,
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please insert your email.";
                  } else if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                    return "please insert a valid email format.";
                  } else {
                    return null;
                  }
                },
                onChange: (value) {
                  onchange();
                  _updateProfileBloc.add(EmailChanged(value));
                },
              ),
              const SizedBox(
                height: 15,
              ),
              NiceButton(
                text: 'Update',
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    _updateProfileBloc.add(UpdateButtonPressed());
                    if (state is UpdateInfoSuccess) {
                      Navigator.of(context).pop();
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
