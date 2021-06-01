import 'package:flutter/material.dart';
import 'dart:async';

import 'tabs/monitor.dart'; // Imports the monitor page
import 'tabs/activity.dart'; // Imports the activity page
import 'tabs/learn.dart'; // Imports the learn page
import './navbar.dart'; // Imports the tab bar

class Home extends StatefulWidget {
  final String username;

  Home({this.username});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String greeting;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  }

  void _getTime() {
    if (DateTime.now().hour >= 0 && DateTime.now().hour < 12) {
      setState(() {
        greeting = "Good morning,";
      });
    } else if (DateTime.now().hour >= 12 && DateTime.now().hour < 18) {
      setState(() {
        greeting = "Good afternoon,";
      });
    } else {
      setState(() {
        greeting = "Good evening,";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: new Scaffold(
          body: TabBarView(
            children: [
              Activity(widget.username, greeting), // Activity page
              Monitor(widget.username, greeting), // Monitor page
              Learn(), // Learn Page
            ],
          ),
          bottomNavigationBar: NavBar(),
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
