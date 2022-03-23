import 'package:clockworker/api/serviceApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'screen.dart';
import 'widget/widgets.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailControler = TextEditingController();
  TextEditingController passControler = TextEditingController();
  TextEditingController confpassControler = TextEditingController();
  TextEditingController telControler = TextEditingController();
  TextEditingController nomControler = TextEditingController();
  TextEditingController prenomControler = TextEditingController();
  var apiService = ServiceApi();
  bool? client;
  bool? prestataire;
  List? listVille = [
    'Maroua',
    'Douala',
    'Yaoundé ',
    'Bamenda',
    'Ngaoundéré',
    'Loum',
    'Nkongsamba',
  ];
  Object? ville = 'Ville';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Créer un compte",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Icon(IconlyBroken.addUser, size: 95.0),
            SizedBox(height: 20.0),
            CustomTextField(
              controller: nomControler,
              prefixIcon: Icon(Icons.person_outline),
              hintText: "Name",
              isPass: false,
            ),
            CustomTextField(
              controller: prenomControler,
              prefixIcon: Icon(Icons.person_add_alt),
              hintText: "Surname",
              isPass: false,
            ),
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
            CustomTextField(
              controller: confpassControler,
              prefixIcon: Icon(Icons.vpn_key),
              hintText: "Confirm password",
              isPass: true,
            ),
            CustomTextField(
              controller: telControler,
              prefixIcon: Icon(Icons.phone),
              hintText: "Phone",
              isPass: false,
            ),
            Card(
              child: Container(
                height: 60.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: Colors.grey)),
                child: Center(
                  child: DropdownButton(
                      isExpanded: true,
                      underline: SizedBox(),
                      hint: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              IconlyBold.home,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 15.0),
                            Text(ville.toString()),
                          ],
                        ),
                      ),
                      focusColor: Colors.black,
                      iconEnabledColor: Colors.black,
                      dropdownColor: Colors.white,
                      items: listVille!
                          .map((e) => DropdownMenuItem(
                                child: Text(e,
                                    style: TextStyle(
                                      color: Colors.black,
                                    )),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (newVille) {
                        setState(() {
                          ville = newVille!;
                        });
                      }),
                ),
              ),
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
              textButton: "Sign Up",
              onPressed: () {
                if (emailControler.text.isEmpty ||
                    confpassControler.text.isEmpty ||
                    passControler.text.isEmpty ||
                    telControler.text.isEmpty)
                  errorDialogueCard(
                      "Erreur", "Entrez tous les champs svp.", context);
                else if (passControler.text != confpassControler.text)
                  errorDialogueCard("Erreur",
                      "Les deux mots de passe son different.", context);
                else if (client == null || prestataire == null)
                  errorDialogueCard(
                      "Erreur", "Selectionner le type de compte.", context);
                else
                  apiService.getSignUp(
                      context: context,
                      name: nomControler.text,
                      surname: prenomControler.text,
                      email: emailControler.text,
                      password: passControler.text,
                      phone: telControler.text,
                      ville: ville.toString(),
                      compte: client! ? 'client' : 'prestataire');
              },
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
