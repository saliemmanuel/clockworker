import 'package:clockworker/api/serviceApi.dart';
import 'package:clockworker/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screen.dart';
import 'widget/widgets.dart';

class PrestataireDetailScreen extends StatefulWidget {
  final String? title;
  final String? description;
  final String? clientid;

  const PrestataireDetailScreen(
      {Key? key, this.title, this.description, this.clientid})
      : super(key: key);

  @override
  _PrestataireDetailScreenState createState() =>
      _PrestataireDetailScreenState();
}

class _PrestataireDetailScreenState extends State<PrestataireDetailScreen> {
  var serviceApi = ServiceApi();
  List? user;
  var pref;
  @override
  void initState() {
    getPublication();
    super.initState();
  }

  getPublication() async {
    pref = await SharedPreferences.getInstance();
    user = await serviceApi.getPresInfo(widget.clientid!);
    setState(() {});
    print(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text("Prestataire"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                Container(
                  height: 95.0,
                  width: 95.0,
                  child: Icon(
                    IconlyBold.profile,
                    size: 75.0,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(25.0)),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      widget.title!,
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    height: 90.0,
                    width: 130.0,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "3500",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 27.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Fcfa / h",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(25.0)),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    height: 90.0,
                    width: 130.0,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 40.0,
                          ),
                          Text(
                            "Notez",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(25.0)),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text('Descrition : \n${widget.description}'),
          ),
          CustomBanerHeader(
            title: 'Informations sur le pretataire.',
          ),
          user == null
              ? Center(
                  child:
                      CircularProgressIndicator(color: Palette.iconBottomColor))
              : Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Card(
                        child: ListTile(
                            leading: Icon(IconlyBold.profile),
                            title: SelectableText(
                                user![0]['name'] + ' ' + user![0]['surname']),
                            subtitle: Text("Nom et prenom"),
                            trailing: Icon(IconlyBold.edit)),
                      ),
                      Card(
                        child: ListTile(
                            leading: Icon(IconlyBold.paper),
                            title: SelectableText(user![0]['email']),
                            subtitle: Text("E-mail"),
                            trailing: Icon(IconlyBold.edit)),
                      ),
                      user![0]['status'] == null
                          ? SizedBox()
                          : Card(
                              child: ListTile(
                                  leading: Icon(IconlyBold.profile),
                                  title:
                                      SelectableText(user![0]['status'] ?? ""),
                                  subtitle: Text("Status"),
                                  trailing: Icon(IconlyBold.edit)),
                            ),
                      Card(
                        child: ListTile(
                            leading: Icon(Icons.phone),
                            title: SelectableText(user![0]['phone']),
                            subtitle: Text("Phone"),
                            trailing: Icon(IconlyBold.edit)),
                      ),
                      Card(
                        child: ListTile(
                            leading: Icon(IconlyBold.home),
                            title: SelectableText(user![0]['ville_id']),
                            subtitle: Text("Ville"),
                            trailing: Icon(IconlyBold.edit)),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              textButton: "Contacter",
                              onPressed: () async => await pushNewPage(
                                  DiscutionScreen(
                                      title: null,
                                      clientid: pref.getString('id'),
                                      prestataireid: user![0]['id']),
                                  context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
