import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool? isPass;
  final Icon? prefixIcon;
  final String? hintText;
  const CustomTextField(
      {Key? key, this.isPass, this.prefixIcon, this.hintText, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: TextField(
        controller: controller,
        obscureText: isPass! ? true : false,
        enableSuggestions: true,
        cursorColor: Colors.black,
        autocorrect: true,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            prefixIcon: prefixIcon,
            hintText: hintText,
            alignLabelWithHint: true),
      ),
    );
  }
}
