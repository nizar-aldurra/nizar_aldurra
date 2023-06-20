import 'package:flutter/material.dart';

class NiceButton extends StatelessWidget {
  String? text;
  Function()? onPress;

  NiceButton({
    this.text,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: onPress,
        child: Text(text!),
      ),
    );
  }
}
