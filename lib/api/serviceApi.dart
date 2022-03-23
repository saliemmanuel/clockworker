import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:clockworker/screen/screen.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:clockworker/screen/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceApi {
  static Uri urlApi() {
    return Uri.parse("http://192.168.43.28/clockwork/public");
  }

  getSignUp(
      {String? name,
      String? surname,
      String? email,
      String? password,
      String? phone,
      String? compte,
      var context,
      String? ville}) async {
    simpleDialogueCardSansTitle("Traitement en cour ...", context);
    if (compte == 'client') {
      var data = await http.post(ServiceApi.urlApi(), body: {
        "service": 'inscription',
        "name": name,
        "surname": surname,
        "email": email,
        "password": password,
        "phone": phone,
        "picture": "picture",
        "isactive": "true",
        "ville_id": ville,
        "compte": compte
      });

      if (data.statusCode == 200) {
        var response = jsonDecode(data.body);
        if (response[0]['error'] == '0') {
          Navigator.pop(context);
          errorDialogueCard("Créer un compte", response[0]['message'], context)
              .then((value) => Navigator.pop(context));
        } else {
          Navigator.pop(context);
          errorDialogueCard("Erreur !!!", "${response[0]['message']}", context);
        }
      }
    } else {
      var data = await http.post(ServiceApi.urlApi(), body: {
        "service": 'inscription',
        "name": name,
        "surname": surname,
        "email": email,
        "password": password,
        "status": "NaN",
        "phone": phone,
        "picture": "picture",
        "isactive": "true",
        "ville_id": ville,
        "compte": compte
      });
      if (data.statusCode == 200) {
        var response = jsonDecode(data.body);
        if (response[0]['error'] == '0') {
          Navigator.pop(context);
          errorDialogueCard("Inscription", response[0]['message'], context)
              .then((value) => Navigator.pop(context));
        } else {
          Navigator.pop(context);
          errorDialogueCard("Erreur !!!", "${response[0]['message']}", context);
        }
      }
    }
  }

  getSigIn({String? email, String? pass, String? compte, var context}) async {
    simpleDialogueCardSansTitle("Connexion en cour ...", context);
    var data = await http.post(ServiceApi.urlApi(), body: {
      "service": "connexion",
      "email": email,
      "password": pass,
      "compte": compte
    });
    if (data.statusCode == 200) {
      var pref = await SharedPreferences.getInstance();
      var response = jsonDecode(data.body);
      if (response[0]['error'] == '0') {
        pref.setString('user', response.toString());
        pref.setString('id', response[0]['id']);
        pref.setString('name', response[0]['name']);
        pref.setString('surname', response[0]['surname']);
        pref.setString('email', response[0]['email']);
        pref.setString('status', response[0]['status'] ?? "");
        pref.setString('phone', response[0]['phone']);
        pref.setString('ville_id', response[0]['ville_id']);
        pref.setString('compte', compte!);
        errorDialogueCard("Connexion", response[0]['message'], context);
        pushNewPageRemoveUntil(
            Home(
                id: pref.getString('id'),
                name: pref.getString('name'),
                surname: pref.getString('surname'),
                email: pref.getString('email'),
                status: pref.getString('status'),
                phone: pref.getString('phone'),
                villeid: pref.getString('ville_id'),
                compte: pref.getString('compte'),
                data: pref.getString('user')),
            context);
        print(pref.getString('user'));
      } else {
        Navigator.pop(context);
        errorDialogueCard("Erreur !!!", response[0]['message'], context);
      }
    }
  }

  getAnnonces() async {
    var data = await http.post(ServiceApi.urlApi(), body: {
      "service": "annonce",
    });
    if (data.statusCode == 200) {
      var response = jsonDecode(data.body);
      if (response[0]['error'] == '0') {
        return response[0]['data'];
      }
    }
  }

  getPublication() async {
    var data = await http.post(ServiceApi.urlApi(), body: {
      "service": "publication",
    });
    if (data.statusCode == 200) {
      var response = jsonDecode(data.body);
      if (response[0]['error'] == '0') {
        return response[0]['data'];
      }
    }
  }

  getClientData(String id) async {
    var data = await http.post(ServiceApi.urlApi(),
        body: {"service": "getclient", "client_id": id});
    if (data.statusCode == 200) {
      var response = jsonDecode(data.body);
      if (response[0]['error'] == '0') {
        return response;
      }
    }
  }

  getPresInfo(String id) async {
    var data = await http.post(ServiceApi.urlApi(),
        body: {"service": "getPresInfo", "prestataire_id": id});
    if (data.statusCode == 200) {
      var response = jsonDecode(data.body);

      if (response[0]['error'] == '0') {
        return response;
      }
    }
  }

  getDiscution({String? id, var compte}) async {
    var data = await http.post(ServiceApi.urlApi(), body: {
      "service": "getDiscution",
      "prestataire_id": id,
      "client_id": id,
      "compte": compte
    });
    if (data.statusCode == 200) {
      var response = jsonDecode(data.body);

      if (response[0]['error'] == '0') {
        return response[0]['data'];
      }
    }
  }

  getConversation({String? prestataire, String? client}) async {
    var data = await http.post(ServiceApi.urlApi(), body: {
      "service": "getConversation",
      "prestataire_id": prestataire,
      "client_id": client,
    });
    if (data.statusCode == 200) {
      var response = jsonDecode(data.body);
      if (response[0]['error'] == '0') {
        return response[0]['data'];
      }
    }
  }

  sendMessage(var bdy) async {
    var data = await http.post(ServiceApi.urlApi(), body: {
      "service": "sendMessage",
      "message": bdy!['message'],
      "readstatus": 'ok',
      "receivedstatus": 'none',
      "deletestatus": 'none',
      "client_id": bdy!['client_id'],
      "prestataire_id": bdy!['prestataire_id'],
      "created_at": bdy!['date'],
    });
    if (data.statusCode == 200) {}
  }

  getPubForPres(String id) async {
    var data = await http.post(ServiceApi.urlApi(),
        body: {"service": "getPubForPres", "prestataire_id": id});
    if (data.statusCode == 200) {
      var response = jsonDecode(data.body);
      if (response[0]['error'] == '0') {
        return response[0]['data'];
      }
    }
  }

  getPubForClient(String id) async {
    var data = await http.post(ServiceApi.urlApi(),
        body: {"service": "getPubForClient", "client_id": id});
    if (data.statusCode == 200) {
      var response = jsonDecode(data.body);
      if (response[0]['error'] == '0') {
        return response[0]['data'];
      }
    }
  }

  putPub({String? title, String? description, String? id}) async {
    var data = await http.post(ServiceApi.urlApi(), body: {
      "service": "putPub",
      "title": title,
      "description": description,
      "prestataire_id": id,
    });
    if (data.statusCode == 200) {}
  }

  putAnn({String? title, String? description, String? id}) async {
    var data = await http.post(ServiceApi.urlApi(), body: {
      "service": "putAnn",
      "title": title,
      "description": description,
      "client_id": id,
    });
    if (data.statusCode == 200) {}
  }
}
