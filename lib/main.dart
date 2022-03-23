import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/config.dart';
import 'screen/screen.dart';

// @autor
// SALI EMMANUEL
// Tel : 237 698066896
// github : github.com/saliemmanuel

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var pref = await SharedPreferences.getInstance();
  runApp(
    MaterialApp(
      title: "clockworker",
      home: pref.getString('user') == null
          ? SigninPage()
          : Home(
              id: pref.getString('id'),
              name: pref.getString('name'),
              surname: pref.getString('surname'),
              email: pref.getString('email'),
              status: pref.getString('status'),
              phone: pref.getString('phone'),
              villeid: pref.getString('ville_id'),
              compte: pref.getString('compte'),
              data: pref.getString('user')),
      theme: ThemeApp.lightTheme(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
