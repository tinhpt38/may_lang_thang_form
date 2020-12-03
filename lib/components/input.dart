import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String title;
  final TextEditingController controller;

  Input({this.title, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: title,
        ),
      ),
    );
  }
}
