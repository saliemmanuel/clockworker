import 'package:clockworker/api/serviceApi.dart';
import 'package:clockworker/data/data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widget/widgets.dart';

class AddService extends StatefulWidget {
  const AddService({Key? key}) : super(key: key);

  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  var title = TextEditingController();
  var description = TextEditingController();
  var serviceApi = ServiceApi();
  var pubPresta;
  var pid;
  @override
  void initState() {
    getPubFP();
    super.initState();
  }

  getPubFP() async {
    var pref = await SharedPreferences.getInstance();
    pid = pref.getString('id');
    pubPresta = await serviceApi.getPubForPres(pid);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text("Ajouter publication"),
      ),
      body: ListView(
        children: [
          CustomBanerHeader(title: 'Ajouter une publication'),
          CustomTextField(
            controller: title,
            prefixIcon: Icon(Icons.add),
            hintText: "Title",
            isPass: false,
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Card(
              child: Container(
                height: 150.0,
                child: TextField(
                  controller: description,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: '   Descriptions'),
                ),
              ),
            ),
          ),
          CustomButton(
              textButton: "Ajouter",
              onPressed: () {
                serviceApi.putPub(
                    title: title.text, description: description.text, id: pid);
                getPubFP();
                title.clear();
                description.clear();
                setState(() {});
              }),
          pubPresta == null
              ? Container()
              : CustomBanerHeader(title: 'Liste de vos publications'),
          pubPresta == null
              ? Container()
              : ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: pubPresta == null ? 0 : pubPresta.length,
                  reverse: true,
                  itemBuilder: (_, i) => Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CustomCard(
                      nomPrenom: pubPresta[i]['prestataire_id'].toString(),
                      note: 0,
                      payement: '3500',
                      statut: 'freelance',
                      typeService: pubPresta[i]['title'],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
