import 'package:clockworker/config/config.dart';
import 'package:flutter/material.dart';

Future simpleDialogueCard(String title, String msg, BuildContext context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 15.0),
              Text(msg)
            ],
          ),
        );
      });
}

Future simpleDialogueCardSansTitle(String msg, BuildContext context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 15.0),
              Text(msg)
            ],
          ),
        );
      });
}

Future errorDialogueCard(String title, String msg, BuildContext context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            TextButton(
              child:
                  Text("Ok", style: TextStyle(color: Palette.iconBottomColor)),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      });
}
