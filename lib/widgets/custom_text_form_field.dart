import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final String? Function(String?) validator;

  CustomTextFormField({
    required this.controller,
    required this.label,
    this.obscureText = false,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)),
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
      ),
      validator: validator,
    );
  }
}
