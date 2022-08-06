import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final TextInputType? type;
  const CustomTextField(
      {Key? key, required this.text, required this.controller, this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: type,
      controller: controller,
      decoration: InputDecoration(
        hintText: text,
      ),
    );
  }
}
