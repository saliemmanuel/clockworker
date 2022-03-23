import 'package:clockworker/config/config.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? textButton;
  final Function()? onPressed;
  const CustomButton({Key? key, this.textButton, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(15.0),
        width: 165.0,
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.cover,
          child: Text(
            textButton ?? " ",
            style: TextStyle(
                color: Colors.white,
                fontSize: 19.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        decoration: BoxDecoration(
            color: Palette.iconBottomColor,
            borderRadius: BorderRadius.circular(12.0)),
      ),
      onTap: onPressed,
    );
  }
}
