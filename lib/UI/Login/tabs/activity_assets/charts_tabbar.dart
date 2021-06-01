import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

import 'chart1.dart';
import 'chart2.dart';
import 'chart3.dart';

class ChartsTabBar extends StatefulWidget {
  @override
  _ChartsTabBarState createState() => _ChartsTabBarState();
}

class _ChartsTabBarState extends State<ChartsTabBar>
    with TickerProviderStateMixin {
  TabController _chartsTabController;

  File jsonFile;
  Directory dir;
  String fileName = "BPDatta.json";
  bool fileExists = false;
  List<dynamic> fileContent = [];

  @override
  void initState() {
    super.initState();

    _chartsTabController = new TabController(length: 3, vsync: this);
    getExternalStorageDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists)
        this.setState(
            () => fileContent = json.decode(jsonFile.readAsStringSync()));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _chartsTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: TabBarView(
            controller: _chartsTabController,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LineChart(
                  //Line Chart data
                  sampleData1(),
                  swapAnimationDuration: const Duration(milliseconds: 250),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LineChart(
                  sampleData2(),
                  swapAnimationDuration: const Duration(milliseconds: 250),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LineChart(
                  sampleData3(),
                  swapAnimationDuration: const Duration(milliseconds: 250),
                ),
              ),
            ],
          ),
          appBar: TabBar(
            tabs: <Widget>[
              Tab(
                text: "Last week",
              ),
              Tab(
                text: "Last month",
              ),
              Tab(
                text: "Last year",
              ),
            ],
            labelColor: Colors.pink,
            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(6.0),
            indicatorColor: Color(0xffFE7575),
            controller: _chartsTabController,
            isScrollable: false,
          ),
        ),
      ),
    );
  }
}
