import 'package:flutter/material.dart';

class NiceTextField extends StatelessWidget {
  String? hintText;
  String? initialValue;
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
  bool? autofocus ;
  FocusNode? focusNode;
  void Function()? onTap;
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
    this.initialValue,
    this.autofocus =false,
    this.focusNode,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        onTap: onTap,
        autofocus: autofocus!,
        focusNode: focusNode,
        initialValue: initialValue,
        onChanged: onChange,
        keyboardType: keyboardType ?? TextInputType.text,
        maxLines: maxLines ?? 1,
        controller: controller,
        validator: validator,
        obscureText: obscureText ?? false,
        textInputAction: TextInputAction.next,
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
