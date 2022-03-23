import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widget/widgets.dart';

class NotificatonScreen extends StatefulWidget {
  const NotificatonScreen({Key? key}) : super(key: key);

  @override
  _NotificatonScreenState createState() => _NotificatonScreenState();
}

class _NotificatonScreenState extends State<NotificatonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      drawer: Drawer(),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text("Notifications"),
      ),
      body: CupertinoScrollbar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            itemCount: 150,
            separatorBuilder: (_, i) => SizedBox(height: 10.0),
            itemBuilder: (_, i) => Container(),
          ),
        ),
      ),
    );
  }
}
