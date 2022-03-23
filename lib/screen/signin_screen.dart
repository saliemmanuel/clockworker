import 'dart:developer';

import 'package:clockworker/api/serviceApi.dart';
import 'package:clockworker/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'screen.dart';
import 'widget/widgets.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  bool? client;
  bool? prestataire;
  TextEditingController emailControler = TextEditingController();
  TextEditingController passControler = TextEditingController();
  var serviceApi = ServiceApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Connexion",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Icon(IconlyBroken.profile, size: 95.0),
            SizedBox(height: 20.0),
            CustomTextField(
              controller: emailControler,
              prefixIcon: Icon(Icons.mail_outline),
              hintText: "E-mail address",
              isPass: false,
            ),
            CustomTextField(
              controller: passControler,
              prefixIcon: Icon(Icons.vpn_key),
              hintText: "Password",
              isPass: true,
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Type de Compte",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      child: Container(
                          height: 40.0,
                          alignment: Alignment.center,
                          child: Text(
                            "Compte client ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 19.0,
                                fontWeight: FontWeight.bold),
                          ),
                          decoration: BoxDecoration(
                            color: client == true ? Colors.green : Colors.grey,
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                      onTap: () {
                        setState(() {
                          prestataire = false;
                          client = true;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: InkWell(
                      child: Container(
                          alignment: Alignment.center,
                          height: 40.0,
                          child: Text(
                            "Compte prestataire ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 19.0,
                                fontWeight: FontWeight.bold),
                          ),
                          decoration: BoxDecoration(
                            color: prestataire == true
                                ? Colors.green
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                      onTap: () {
                        setState(() {
                          prestataire = true;
                          client = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            CustomButton(
                textButton: "Sign In",
                onPressed: () {
                  if (emailControler.text.isEmpty || passControler.text.isEmpty)
                    errorDialogueCard("Erreur",
                        "Entrez un e-mail address et password svp.", context);
                  else if (client == null || prestataire == null)
                    errorDialogueCard(
                        "Erreur", "Selectionner le type de compte.", context);
                  else
                    serviceApi.getSigIn(
                        email: emailControler.text,
                        pass: passControler.text,
                        context: context,
                        compte: client! ? 'client' : 'prestataire');
                }),
            SizedBox(height: 10.0),
            TextButton(
              child: Text("Pas de compte ? Créer un compte",
                  style: TextStyle(color: Palette.couleursecondaire)),
              onPressed: () {
                return pushNewPage(SignupPage(), context);
              },
            )
          ],
        ),
      ),
    );
  }
}
