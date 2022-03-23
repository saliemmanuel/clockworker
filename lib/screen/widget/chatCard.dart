import 'package:clockworker/api/serviceApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatCard extends StatefulWidget {
  final clientid;
  final prestataireid;
  const ChatCard(
      {Key? key, required this.clientid, required this.prestataireid})
      : super(key: key);

  @override
  _ChatCardState createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  var serviceApi = ServiceApi();
  List? _getInf;
  @override
  void initState() {
    getInf();
    super.initState();
  }

  getInf() async {
    var pref = await SharedPreferences.getInstance();
    if (pref.getString('compte') == 'prestataire')
      _getInf = await serviceApi.getClientData(widget.clientid!);
    else
      _getInf = await serviceApi.getPresInfo(widget.prestataireid);
    setState(() {});
  }

  // getClientInf() async {
  //   var pref = await SharedPreferences.getInstance();
  //   if (pref.getString('compte') == 'prestataire')
  //     _getInf = await serviceApi.getPresInfo(widget.id!);
  //   else
  //     _getInf = await serviceApi.getClientData(widget.id!);
  //   print(widget.id!);
  //   print(_getInf);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(IconlyBold.profile, size: 40.0),
        title: _getInf == null
            ? CupertinoActivityIndicator()
            : Text(_getInf![0]['name'] + " " + _getInf![0]['surname']),
        subtitle: Text(' '),
      ),
    );
  }
}
