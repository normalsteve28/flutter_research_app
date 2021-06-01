import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'activity_assets/activity_person.dart'; // this contains the icon
import 'activity_assets/goodmorning_jd.dart'; // this contains the good morning text with name
import 'activity_assets/history_boxes.dart'; // Contains history box
import '../see_all_buttons.dart'; // SEE ALL button handler
import 'activity_assets/charts_tabbar.dart';

class Activity extends StatefulWidget {
  final String username;
  final String greeting;

  Activity(this.username, this.greeting);

  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  bool isShowingMainData;
  bool dataNotEmpty = true;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
    dataNotEmpty = true;
  }

  /* void checkIfDataEmpty() {
    if (sys.length > 0 &&
        dia.length > 0 &&
        heartRate.length > 0 &&
        sys.length == dia.length &&
        dia.length == heartRate.length) {
      dataEmpty = false;
    } else {
      dataEmpty = true;
    }
  } */

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink[50],
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ActivityPerson(), // This widget is the icon
              GoodMorning(
                  widget.username,
                  widget
                      .greeting), // This widget is the good morning text with the name
            ],
          ),
          Row(
            // "My History" and SEE ALL button
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  "My History",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // SeeAllButton(null)
            ],
          ),
          HistoryBoxes(),
          Row(
            //"Statistics" and SEE ALL button
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  "Statistics",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TextButton(
                onPressed: null, //checkIfDataEmpty,
                child: Text("Refresh"),
              ),
              // SeeAllButton(null)
            ],
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3ffe7575),
                    blurRadius: 8,
                    offset: Offset(0, -1),
                  ),
                ],
                color: Color(0xfffafafa),
              ),
              child: AspectRatio(
                // Chart
                aspectRatio: 1.23,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    /* gradient: LinearGradient(
                      colors: [
                        Color(0xff2c274c),
                        Color(0xff46426c),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ), */
                    color: Color(0xfffafafa),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: dataNotEmpty
                                ? ChartsTabBar()
                                : Center(
                                    child: Text(
                                      "You haven't started measuring yet.",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
