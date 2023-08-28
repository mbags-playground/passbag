import 'package:flutter/material.dart';

class StyledTextInput extends StatelessWidget {
  String text;

  TextEditingController? controller;
  bool isPasswordField;
  Widget? suffixIcon;
  Function(String)? onChanged;
  StyledTextInput(
      {required this.text,
      this.controller,
      this.onChanged,
      this.isPasswordField = false,
      this.suffixIcon});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      obscureText: isPasswordField,
      style: TextStyle(fontSize: 16.0, color: Colors.black), // Text style
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(15.0), // Padding inside the text box
          hintText: text, // Placeholder text
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          suffixIcon: suffixIcon),
    );
  }
}
