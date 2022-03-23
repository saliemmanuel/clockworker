import 'package:clockworker/api/serviceApi.dart';
import 'package:clockworker/config/config.dart';
import 'package:clockworker/data/data.dart';
import 'package:clockworker/screen/screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'widget/widgets.dart';

class PrestataireHomeScreen extends StatefulWidget {
  final id;
  final name;
  final surname;
  final email;
  final status;
  final phone;
  final villeid;
  const PrestataireHomeScreen(
      {Key? key,
      this.id,
      this.name,
      this.surname,
      this.email,
      this.status,
      this.phone,
      this.villeid})
      : super(key: key);

  @override
  _PrestataireHomeScreenState createState() => _PrestataireHomeScreenState();
}

class _PrestataireHomeScreenState extends State<PrestataireHomeScreen> {
  var serviceApi = ServiceApi();
  List? _annonces;
  @override
  void initState() {
    getAnnonce();
    super.initState();
  }

  getAnnonce() async {
    _annonces = await serviceApi.getAnnonces();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      drawer: Drawer(),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text("Accueil prestataire"),
        actions: [
          InkWell(
            child: CircleAvatar(child: Icon(IconlyBold.profile)),
            onTap: () => pushNewPage(
                UserAccountScreen(
                  id: widget.id,
                  name: widget.name,
                  surname: widget.surname,
                  email: widget.email,
                  phone: widget.phone,
                  status: widget.status,
                  villeid: widget.villeid,
                ),
                context),
          ),
          SizedBox(width: 10.0)
        ],
      ),
      body: CupertinoScrollbar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              CategoriesList(listService: listService, listAnnonces: annonces),
              CustomBanerHeader(title: 'Meuilleurs service demandé'),
              _annonces == null
                  ? Center(
                      child: CircularProgressIndicator(
                          color: Palette.iconBottomColor))
                  : AnnonceList(listAnnonces: _annonces)
            ],
          ),
        ),
      ),
    );
  }
}
