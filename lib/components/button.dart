import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback onPress;
  final String label;

  Button({this.onPress, this.label});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
      color: Color(0xff353535),
      onPressed: onPress,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(90))),
      child: Text(
        label == null ? "Continue" : label,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
