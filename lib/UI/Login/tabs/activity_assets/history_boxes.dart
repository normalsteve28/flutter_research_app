import 'package:flutter/material.dart';
import 'bp_data.dart';

class HistoryBoxes extends StatefulWidget {
  @override
  _HistoryBoxesState createState() => _HistoryBoxesState();
}

class _HistoryBoxesState extends State<HistoryBoxes> {
  final List<Widget> items = [];
  int index = -1;

  printListLength() {
    print("Systolic list length: ${sys.length}");
    print("Diastolic list length: ${dia.length}");
    print("Heart rare list length: ${heartRate.length}");
  }

  addHistoryBox() {
    items.add(
      // Adds history box with systolic, diastolic, heart rate values
      HistoryBoxContainer(index),
    );
  }

  removeHistoryBox() {
    // removes history boxes
    items.removeLast();
    sys.remove(0);
    dia.remove(0);
    heartRate.remove(0);
    index -= 1;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        // This SingleChildScrollView allows the horizontal scrolling of the contents
        // of the child of Container, which is Row
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Container(
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              // The children below are boxes, will have to replace with a map of a list soon
              children: [
                Column(
                  children: [
                    RaisedButton(
                        // Button that adds history boxes
                        onPressed: () {
                          setState(() {
                            if (dataIsEqualNotEmpty) {
                              // This code is executed if the dataset is not empty
                              index += 1;
                              if (index == sys.length - 1) {
                                // This code executes if the index is is the last index
                                addHistoryBox();
                              } else {
                                /* 
                                This code executes if the index is not the last index.
                                The reason for this check is to prevent 
                                */
                                sys.add(0);
                                dia.add(0);
                                heartRate.add(0);
                                index = sys.length - 1;
                                addHistoryBox();
                              }
                            } else {
                              sys.add(0);
                              dia.add(0);
                              heartRate.add(0);
                              index += 1;
                              addHistoryBox();
                            }
                          });
                          printListLength();
                        },
                        child: Text('Add')),
                    RaisedButton(
                        // Button that removes history boxes
                        onPressed: () {
                          setState(() {
                            removeHistoryBox();
                          });
                          printListLength();
                        },
                        child: Text('Remove'))
                  ],
                ),
                items.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("You havent started measuring yet.",
                            style: TextStyle(fontSize: 18)),
                      )
                    : Container(),
                ...items,
              ]),
        ));
  }
}

class HistoryBoxContainer extends StatelessWidget {
  final int index;

  HistoryBoxContainer(this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        width: 164,
        height: 91,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Color(0x7f000000),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Row(
              // Systolic
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Systolic:",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                  ),
                ),
                Text(
                  "${sys[index]} mmhg",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Row(
              // Diastolic
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Diastolic:",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                  ),
                ),
                Text(
                  "${dia[index]} mmhg",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Row(
              // Heart Rate
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Heart Rate:",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                  ),
                ),
                Text(
                  "${heartRate[index]} bpm",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
