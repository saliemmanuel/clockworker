import 'package:clockworker/config/config.dart';
import 'package:clockworker/screen/screen.dart';
import 'package:curved_nav_bar/curved_bar/curved_action_bar.dart';
import 'package:curved_nav_bar/fab_bar/fab_bottom_app_bar_item.dart';
import 'package:curved_nav_bar/flutter_curved_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'client_search_screen.dart';
import 'widget/widgets.dart';

class Home extends StatefulWidget {
  final String? compte;
  final data;
  final id;
  final name;
  final surname;
  final email;
  final status;
  final phone;
  final villeid;
  const Home(
      {Key? key,
      required this.compte,
      required this.data,
      this.id,
      this.name,
      this.surname,
      this.email,
      this.status,
      this.phone,
      this.villeid})
      : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    List _data = [];
    _data.add(widget.data);
    var pages = widget.compte == 'client'
        ? [
            ClientHomeScreen(
              id: widget.id,
              name: widget.name,
              surname: widget.surname,
              email: widget.email,
              phone: widget.phone,
              status: widget.status,
              villeid: widget.villeid,
            ),
            ClientSearchScreen(),
            ChatScreen(),
            NotificatonScreen()
          ]
        : [
            PrestataireHomeScreen(
              id: widget.id,
              name: widget.name,
              surname: widget.surname,
              email: widget.email,
              phone: widget.phone,
              status: widget.status,
              villeid: widget.villeid,
            ),
            PrstataireSearchScreen(),
            ChatScreen(),
            NotificatonScreen()
          ];
    return CurvedNavBar(
      actionButton: CurvedActionBar(
        activeIcon: Container(
          padding: EdgeInsets.all(8),
          decoration:
              BoxDecoration(color: Palette.dotColor, shape: BoxShape.circle),
          child: Icon(
            Icons.add,
            size: 40.0,
            color: Colors.white,
          ),
        ),
        inActiveIcon: Container(
          padding: EdgeInsets.all(8),
          decoration:
              BoxDecoration(color: Palette.dotColor, shape: BoxShape.circle),
          child: Icon(
            Icons.add,
            size: 40.0,
            color: Colors.white,
          ),
        ),
      ),
      activeColor: Palette.iconBottomColor,
      navBarBackgroundColor: Colors.white,
      inActiveColor: Colors.black45,
      appBarItems: [
        FABBottomAppBarItem(
            activeIcon: Icon(
              IconlyBold.home,
              size: 25.0,
              color: Palette.iconBottomColor,
            ),
            inActiveIcon: Icon(
              IconlyLight.home,
              size: 25.0,
              color: Colors.grey,
            ),
            text: 'Accueil'),
        FABBottomAppBarItem(
            activeIcon: Icon(
              IconlyBold.search,
              size: 25.0,
              color: Palette.iconBottomColor,
            ),
            inActiveIcon: Icon(
              IconlyLight.search,
              size: 25.0,
              color: Colors.grey,
            ),
            text: 'Recherche'),
        FABBottomAppBarItem(
            activeIcon: Icon(
              IconlyBold.chat,
              size: 25.0,
              color: Palette.iconBottomColor,
            ),
            inActiveIcon: Icon(
              IconlyLight.chat,
              size: 25.0,
              color: Colors.grey,
            ),
            text: 'Chats'),
        FABBottomAppBarItem(
            activeIcon: Icon(
              IconlyBold.notification,
              size: 25.0,
              color: Palette.iconBottomColor,
            ),
            inActiveIcon: Icon(
              IconlyLight.notification,
              size: 25.0,
              color: Colors.grey,
            ),
            text: 'Notifications'),
      ],
      bodyItems: pages,
      actionBarView: widget.compte == 'client' ? AddAnnonce() : AddService(),
    );
  }
}
