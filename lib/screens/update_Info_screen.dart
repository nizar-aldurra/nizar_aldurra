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
  final UpdateInfoBloc _updateUserBloc = UpdateInfoBloc();
  onchange() {
    setState(() {
      errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    _updateUserBloc.add(UserNameChanged(widget.name));
    _updateUserBloc.add(EmailChanged(widget.email));
    bool isUpdated=false;
    return BlocListener<UpdateInfoBloc, UpdateInfoState>(
      bloc: _updateUserBloc,
      listener: (context, state){
        if (state is UpdateInfoInitial) {
        } else if (state is UpdateInfoLoading) {
        } else if (state is UpdateInfoSuccess) {
          Navigator.pop(context,isUpdated);
        } else if (state is UpdateInfoFailure) {
          errorMessage=state.error;
          isUpdated=false;
        } else {
        }
      },
      child: UpdateForm(context),
    );
  }

  Widget UpdateForm(BuildContext context) {
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
        child: SingleChildScrollView(
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
                  initialValue: widget.name,
                  hintText: 'Enter the name',
                  labelText: 'User Name',
                  icon: Icons.person,
                  maxLines: 1,
                  autofocus: true,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please insert your name';
                    } else {
                      return null;
                    }
                  },
                  onChange: (value) {
                    widget.name=value;
                    onchange();
                    _updateUserBloc.add(UserNameChanged(value));
                    print(value);
                  },
                ),
                NiceTextField(
                  initialValue: widget.email,
                  hintText: 'Enter the email address',
                  labelText: 'Email',
                  icon: Icons.email_outlined,
                  maxLines: 1,
                  keyboardType: TextInputType.emailAddress,
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
                    widget.email=value;
                    onchange();
                    _updateUserBloc.add(EmailChanged(value));
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                NiceButton(
                  text: 'Update',
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      _updateUserBloc.add(UpdateButtonPressed());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
