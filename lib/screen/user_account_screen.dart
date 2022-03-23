import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screen.dart';
import 'widget/widgets.dart';

class UserAccountScreen extends StatefulWidget {
  final id;
  final name;
  final surname;
  final email;
  final status;
  final phone;
  final villeid;
  const UserAccountScreen(
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
  _UserAccountScreenState createState() => _UserAccountScreenState();
}

class _UserAccountScreenState extends State<UserAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text("Compte utilisateur"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  Container(
                    height: 145.0,
                    width: 140.0,
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
                        widget.name + " " + widget.surname,
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        children: [
                          Row(
                            children: List.generate(
                                5,
                                (index) => Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 13.0,
                                    )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              child: ListTile(
                  leading: Icon(IconlyBold.profile),
                  title: Text(widget.email),
                  subtitle: Text("E-mail"),
                  trailing: Icon(IconlyBold.edit)),
            ),
            Card(
              child: ListTile(
                  leading: Icon(IconlyBold.password),
                  title: Text("*********"),
                  subtitle: Text("Password"),
                  trailing: Icon(IconlyBold.edit)),
            ),
            widget.status != null
                ? SizedBox()
                : Card(
                    child: ListTile(
                        leading: Icon(IconlyBold.profile),
                        title: Text(widget.status ?? ""),
                        subtitle: Text("Status"),
                        trailing: Icon(IconlyBold.edit)),
                  ),
            Card(
              child: ListTile(
                  leading: Icon(Icons.phone),
                  title: Text(widget.phone),
                  subtitle: Text("Phone"),
                  trailing: Icon(IconlyBold.edit)),
            ),
            Card(
              child: ListTile(
                  leading: Icon(IconlyBold.home),
                  title: Text(widget.villeid),
                  subtitle: Text("Ville"),
                  trailing: Icon(IconlyBold.edit)),
            ),
            CustomButton(
              textButton: "Déconnexion",
              onPressed: () => getDeconnexion(context),
            ),
          ],
        ),
      ),
    );
  }

  getDeconnexion(var context) async {
    var pref = await SharedPreferences.getInstance();
    pref.remove('user');
    pushNewPageRemoveUntil(SigninPage(), context);
  }
}
