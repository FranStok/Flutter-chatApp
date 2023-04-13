import 'package:flutter/material.dart';

class CustomInputs extends StatelessWidget {
  final Icon icon;
  final String text;
  final bool isPassword;
  final TextEditingController controller;
  final TextInputType inputType;
  const CustomInputs({
    super.key,
    required this.icon,
    required this.text,
    this.isPassword = false,
    this.inputType=TextInputType.text,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, 5),
                  blurRadius: 5)
            ]),
        child: TextField(
          controller: controller,
          autocorrect: false,
          obscureText: isPassword,
          keyboardType: inputType,
          decoration: InputDecoration(
              prefixIcon: icon, border: InputBorder.none, hintText: text),
        ));
  }
}
