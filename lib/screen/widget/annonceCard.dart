import 'package:clockworker/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class AnnonceCard extends StatelessWidget {
  final id;
  final String? title;
  final String? description;
  final String? picture;
  final int? clientid;
  final String? createdat;
  final String? updatedat;

  const AnnonceCard({
    Key? key,
    required this.id,
    this.title,
    this.description,
    this.picture,
    this.clientid,
    this.createdat,
    this.updatedat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      // height: 147.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            child: Icon(IconlyBroken.image2),
          ),
          title: Text(title!, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
