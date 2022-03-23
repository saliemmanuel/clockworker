import 'package:flutter/material.dart';

import '../screen.dart';

class CustomSearchButton extends StatelessWidget {
  final pList;
  final SearchDelegate page;
  const CustomSearchButton({
    Key? key,
    required this.page,
    this.pList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          height: 50.0,
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              SizedBox(width: 10.0),
              Icon(Icons.search, color: Colors.grey),
              SizedBox(width: 10.0),
              Text(
                "Search",
                style: TextStyle(fontSize: 19.0, color: Colors.grey),
              ),
            ],
          ),
        ),
        onTap: () => showSearch(context: context, delegate: page));
  }
}
