import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;

  CustomTextField({@required this.labelText, this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
          child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            labelText: labelText),
      ),
    );
  }
}
