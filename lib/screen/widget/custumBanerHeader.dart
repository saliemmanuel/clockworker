import 'package:flutter/material.dart';

class CustomBanerHeader extends StatelessWidget {
  final String? title;
  const CustomBanerHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 10.0),
      child: Text(
        title!,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
