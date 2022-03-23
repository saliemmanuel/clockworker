import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:clockworker/api/serviceApi.dart';
import 'package:clockworker/data/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widget/widgets.dart';

class DiscutionScreen extends StatefulWidget {
  final title;
  final clientid;

  final prestataireid;
  const DiscutionScreen({
    Key? key,
    required this.prestataireid,
    required this.title,
    required this.clientid,
  }) : super(key: key);

  @override
  _DiscutionScreenState createState() => _DiscutionScreenState();
}

class _DiscutionScreenState extends State<DiscutionScreen> {
  var messageControler = TextEditingController();
  var serviceApi = ServiceApi();
  List? _getConversation;
  @override
  void initState() {
    getInf();
    getConve();
    super.initState();
  }

  getConve() async {
    _getConversation = await serviceApi.getConversation(
        client: widget.clientid, prestataire: widget.prestataireid);
    setState(() {});
  }

  List? _getInf;

  getInf() async {
    var pref = await SharedPreferences.getInstance();
    if (pref.getString('compte') == 'prestataire')
      _getInf = await serviceApi.getClientData(widget.clientid!);
    else
      _getInf = await serviceApi.getPresInfo(widget.prestataireid);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(widget.title ?? _getInf == null
            ? "Chargement..."
            : _getInf![0]['name'] + " " + _getInf![0]['surname']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Flexible(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: _getConversation == null
                        ? []
                        : [
                            ..._getConversation!.map((e) => CustomChatCard(
                                  isMe: true,
                                  date: e['created_at'],
                                  messages: e['message'],
                                ))
                          ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: messageControler,
                  decoration:
                      InputDecoration(hintText: 'Envoyer un message texte'),
                )),
                IconButton(
                  icon: Icon(IconlyBold.send, size: 32.0),
                  onPressed: () async {
                    await serviceApi.sendMessage({
                      'isMe': true,
                      'message': messageControler.text,
                      'date': DateTime.now().toString(),
                      'client_id': widget.clientid,
                      'prestataire_id': widget.prestataireid,
                    });
                    await getConve();
                    setState(() {});
                    messageControler.clear();
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
