import 'package:flutter/material.dart';
import '../marqueewidget.dart';

import './startbutton.dart'; // contains the start button

class Monitor extends StatelessWidget {
  final String username;
  final String greeting;

  Monitor(this.username, this.greeting);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffffebeb),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            children: [
              Padding(
                //This padding surrounds a SizedBox that contains text
                padding: const EdgeInsets.only(top: 40.0),
                child: SizedBox(
                  width: 348,
                  height: 20,
                  child: Text(
                    "It is time to take your blood pressure",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontStyle: FontStyle.normal,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(
                // This SizedBox contains good morning text
                width: 275,
                height: 40,
                child: MarqueeWidget(
                  // This is so that text will scroll if it is bigger than the box
                  direction: Axis.horizontal,
                  child: Text(
                    "$greeting $username",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          StartButton(),
          SizedBox(
            //This SizedBox contains the bottom text
            width: 275,
            height: 70,
            child: Text(
              "\nPlease make sure your blood pressure device is switched on and connected",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Nunito',
                color: Color(0xff5e5e5e),
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
