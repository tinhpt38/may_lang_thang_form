import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool obscureText;
  final Function(String) onChange;

  Input(
      {this.title = "",
      this.controller,
      this.obscureText = false,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: controller,
        obscureText: this.obscureText,
        decoration: InputDecoration(
          hintText: title,
        ),
        onChanged: onChange == null ? (_) {} : onChange,
      ),
    );
  }
}
