import 'package:flutter/material.dart';

import 'dart:async';

import 'widget/widgets.dart';

class SplashScreen extends StatefulWidget {
  final String? userIsconnected;
  const SplashScreen({Key? key, this.userIsconnected}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // var serviceApi = ServiceApi();
  @override
  void initState() {
    iniStplash();
    super.initState();
  }

  iniStplash() async {
   
    // Timer(
    //     Duration(seconds: 2),
    //     () => widget.userIsconnected == null
    //         ? pushNewPageRemoveUntil(
    //             introIsdonne == null
    //                 ? IntroductionPage()
    //                 : HomeScreen(userIsconnected: null),
    //             context)
    //         : pushNewPageRemoveUntil(
    //             introIsdonne == null
    //                 ? IntroductionPage()
    //                 : HomeScreen(userIsconnected: widget.userIsconnected),
    //             context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 75.0),
                Image.asset("assets/image/epharma.png", width: 250.0),
                SizedBox(height: 50.0),
                Text("E-Pharma",
                    style: TextStyle(
                      fontSize: 29.0,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 50.0),
                Container(child: CircularProgressIndicator()),
                SizedBox(height: 100.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
