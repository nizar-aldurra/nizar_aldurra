import 'package:flutter/material.dart';
class NiceTextField extends StatelessWidget {
  String? hintText;
  String? labelText;
  IconData? icon;
  IconData? suffixIcon;
  String? Function(String?)? validator;
  void Function()? suffixIconCallback;
  void Function(String)? onChange;
  double? width;
  double? height;
  TextInputType? keyboardType;
  int? maxLines;
  TextEditingController? controller;
  bool? obscureText;

  NiceTextField({
    this.hintText,
    this.labelText,
    this.icon,
    this.suffixIcon,
    this.validator,
    this.width,
    this.height,
    this.keyboardType,
    this.maxLines,
    this.controller,
    this.suffixIconCallback,
    this.obscureText,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        onChanged: onChange,
        keyboardType: keyboardType ?? TextInputType.text,
        maxLines: maxLines ?? 1,
        controller: controller,
        validator: validator,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          icon: Icon(icon),
          suffixIcon: IconButton(
            icon: Icon(suffixIcon),
            onPressed: suffixIconCallback,
          ),
        ),
      ),
    );
  }
}