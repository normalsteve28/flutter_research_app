import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../assets.dart';
import 'monitortwo.dart'; // Contains page or route that will appear when the button is pressed

class StartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //This is the container that contains the Start button
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.pink,
            spreadRadius: 0,
            blurRadius: 9,
            offset: Offset(4, 4))
      ], borderRadius: BorderRadius.circular(20)),
      child: RaisedButton(
        child: SvgPicture.asset(startButton),
        color: Colors.pink[50],
        padding: EdgeInsets.all(75),
        hoverColor: Color(0xF20202),
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MonitorPageTwo()),
          );
        },
      ),
    );
  }
}
