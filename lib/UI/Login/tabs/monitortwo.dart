import 'package:flutter/material.dart';

class MonitorPageTwo extends StatelessWidget {
  //This class is the page that shows up when you press Start
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      backgroundColor: Colors.pink[50],
      body: Column(
        children: [
          RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Back'),
          ),
        ],
      ),
    ));
  }
}
