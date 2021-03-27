import 'package:flutter/material.dart';

import 'tabs/monitor.dart'; // Imports the monitor page
import 'tabs/activity.dart'; // Imports the activity page
import 'tabs/learn.dart'; // Imports the learn page
import './navbar.dart'; // Imports the tab bar

class Home extends StatelessWidget {
  final String username;

  Home({this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: new Scaffold(
          body: TabBarView(
            children: [
              Activity(username), // Activity page
              Monitor(username), // Monitor page
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
