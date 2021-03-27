import 'package:flutter/material.dart';

//This class contains the good morning text
class GoodMorning extends StatelessWidget {
  final String username;

  GoodMorning(this.username);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Text(
            "Good Morning",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 40,
            width: 200,
            child: SingleChildScrollView(
              // The Expanded and ScrollView allow text to scroll if it's too big
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              primary: true,
              child: Text("$username",
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip),
            ),
          ),
        ],
      ),
    );
  }
}
