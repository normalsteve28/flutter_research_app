import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MonitorPageTwo extends StatelessWidget {
  final String backArrow = 'assets/icons/backarrow.svg';
  //This class is the page that shows up when you press Start
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset(backArrow),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        backgroundColor: Colors.pink[50],
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  "We're sorry! This function (blood pressure measurement) is not available in this version of the app.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 25),
                ),
                Text(
                  "\n\n Paumanhin po! Ang function na ito ay hindi magagamit sa bersyong ito ng app.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 25,
                      fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
