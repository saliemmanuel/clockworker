import 'package:clockworker/config/palette.dart';
import 'package:flutter/material.dart';

class CustomChatCard extends StatelessWidget {
  final bool? isMe;
  final String? messages;

  final String? date;
  const CustomChatCard({Key? key, this.isMe, this.messages, this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        message(isMe: isMe!, message: messages!, date: date!),
      ],
    );
  }
}

message({bool? isMe, String? message, String? date}) {
  return Column(
    crossAxisAlignment:
        isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            message!,
            style: TextStyle(color: Colors.white),
          ),
        ),
        decoration: BoxDecoration(
            color: Palette.receveMessageColors,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(23.0),
              bottomLeft: isMe ? Radius.circular(23.0) : Radius.circular(0.0),
              topLeft: Radius.circular(23.0),
              bottomRight: isMe ? Radius.circular(0.0) : Radius.circular(23.0),
            )),
      ),
      Text(date!)
    ],
  );
}
