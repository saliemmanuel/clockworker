import 'package:clockworker/api/serviceApi.dart';
import 'package:clockworker/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screen.dart';
import 'widget/widgets.dart';

class AnnonceDetailScreen extends StatefulWidget {
  final id;
  final String? title;
  final String? description;
  final String? clientid;
  const AnnonceDetailScreen({
    Key? key,
    this.id,
    this.title,
    this.description,
    this.clientid,
  }) : super(key: key);

  @override
  _AnnonceDetailScreenState createState() => _AnnonceDetailScreenState();
}

class _AnnonceDetailScreenState extends State<AnnonceDetailScreen> {
  var serviceApi = ServiceApi();
  List? user;
  var pref;
  @override
  void initState() {
    getAnnonce();
    super.initState();
  }

  getAnnonce() async {
    pref = await SharedPreferences.getInstance();
    user = await serviceApi.getClientData(widget.clientid!);
    setState(() {});
    print(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text("Annonce"),
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
                    IconlyBold.image,
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
            padding: const EdgeInsets.all(18.0),
            child: Text('Descrition : \n${widget.description}'),
          ),
          CustomBanerHeader(
            title: 'Informations sur l\'annonceur.',
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
                                    clientid: user![0]['id'],
                                    prestataireid: pref.getString('id'),
                                  ),
                                  context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
