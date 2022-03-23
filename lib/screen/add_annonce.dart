import 'package:clockworker/api/serviceApi.dart';
import 'package:clockworker/data/data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widget/widgets.dart';

class AddAnnonce extends StatefulWidget {
  const AddAnnonce({Key? key}) : super(key: key);

  @override
  _AddAnnonceState createState() => _AddAnnonceState();
}

class _AddAnnonceState extends State<AddAnnonce> {
  var title = TextEditingController();
  var description = TextEditingController();
  var annClien;
  var pid;
  var serviceApi = ServiceApi();
  @override
  void initState() {
    getPubFC();
    super.initState();
  }

  getPubFC() async {
    var pref = await SharedPreferences.getInstance();
    pid = pref.getString('id');
    annClien = await serviceApi.getPubForClient(pid);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text("Ajouter Annonce"),
      ),
      body: ListView(
        children: [
          CustomBanerHeader(title: 'Ajouter une annonce'),
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: description,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Descriptions'),
                  ),
                ),
              ),
            ),
          ),
          CustomButton(
              textButton: "Ajouter",
              onPressed: () {
                serviceApi.putAnn(
                    title: title.text, description: description.text, id: pid);
                getPubFC();
                title.clear();
                description.clear();
                setState(() {});
              }),
          annClien == null
              ? Container()
              : CustomBanerHeader(title: 'List de vos annonces'),
          annClien == null
              ? Container()
              : ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: annClien == null ? 0 : annClien.length,
                  reverse: true,
                  itemBuilder: (_, i) => Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: AnnonceCard(
                      id: annClien[i]['id'],
                      title: annClien[i]['title'],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
