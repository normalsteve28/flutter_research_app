import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import './assets.dart';

class NavBar extends StatelessWidget {
  // This class or widget is the tab bar
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter, // 10% of the width, so there are ten bli
          colors: [const Color(0xffffebeb), const Color(0xfffbd3f7)],
        ),
      ),
      child: TabBar(
        tabs: [
          Tab(
            icon: new Container(
              child: SvgPicture.asset(activity),
            ),
          ),
          Tab(
            icon: new Container(
              child: SvgPicture.asset(monitor),
            ),
          ),
          Tab(
            icon: new Container(
              child: SvgPicture.asset(learn),
            ),
          ),
        ],
        labelColor: Colors.pink,
        unselectedLabelColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: EdgeInsets.all(6.0),
        indicatorColor: Color(0xffFE7575),
      ),
    );
  }
}
