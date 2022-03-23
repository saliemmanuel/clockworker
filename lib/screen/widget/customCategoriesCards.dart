import 'package:flutter/material.dart';

class CustomCategoriesCards extends StatelessWidget {
  final dynamic e;
  const CustomCategoriesCards({Key? key, this.e}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 70.0,
              width: 70.0,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage(
                      e['image'],
                    ),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(175.0),
              ),
            ),
          ),
        ),
        Text(e['nom']),
      ],
    );
  }
}
