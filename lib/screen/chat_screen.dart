import 'package:clockworker/api/serviceApi.dart';
import 'package:clockworker/data/data.dart';
import 'package:clockworker/screen/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'discution_screen.dart';
import 'widget/chatCard.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var serviceApi = ServiceApi();
  List? _discution;
  var pref;
  @override
  void initState() {
    _getDiscution();
    super.initState();
  }

  _getDiscution() async {
    pref = await SharedPreferences.getInstance();
    _discution = await serviceApi.getDiscution(
        id: pref.getString('id'), compte: pref.getString('compte'));
    setState(() {});
    print("disss");
    print(_discution);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      drawer: Drawer(),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text("Chats"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView.separated(
          itemCount: _discution == null ? 0 : _discution!.length,
          separatorBuilder: (_, i) => SizedBox(height: 1.0),
          itemBuilder: (_, i) {
            return InkWell(
              child: ChatCard(
                  clientid: _discution![i]['client_id'],
                  prestataireid: _discution![i]['prestataire_id']),
              onTap: () => pushNewPage(
                  DiscutionScreen(
                    clientid: _discution![i]['client_id'],
                    title: null,
                    prestataireid: _discution![i]['prestataire_id'],
                  ),
                  context),
            );
          },
        ),
      ),
    );
  }
}
