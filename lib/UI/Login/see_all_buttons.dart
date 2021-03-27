import 'package:flutter/material.dart';

class SeeAllButton extends StatelessWidget {
  final Function buttonFunction;

  SeeAllButton(this.buttonFunction); // this constructor accepts a function

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: buttonFunction,
      child: Text(
        "SEE ALL",
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: "Nunito",
        ),
      ),
    );
  }
}
