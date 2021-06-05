import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
// import 'package:intl/intl.dart';

import '../../username.dart';

class ChartsOne extends StatefulWidget {
  @override
  _ChartsOneState createState() => _ChartsOneState();
}

class _ChartsOneState extends State<ChartsOne> {
  dynamic currentWD = DateTime.now().weekday;
  int fiveBeforeWD;
  int fourBeforeWD;
  int threeBeforeWD;
  int twoBeforeWD;
  int oneBeforeWD;
  String currentWDStr;
  String fiveBeforeWDStr;
  String fourBeforeWDStr;
  String threeBeforeWDStr;
  String twoBeforeWDStr;
  String oneBeforeWDStr;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 0), (Timer t) => _getTime());
  }

  void _getTime() {
    fiveBeforeWD = currentWD - 5;

    if (fiveBeforeWD == -4) {
      fiveBeforeWDStr = 'MON';
      fourBeforeWDStr = 'TUE';
      threeBeforeWDStr = 'WED';
      twoBeforeWDStr = 'THU';
      oneBeforeWDStr = 'FRI';
      currentWDStr = 'SAT';
    } else if (fiveBeforeWD == -3) {
      fiveBeforeWDStr = 'TUE';
      fourBeforeWDStr = 'WED';
      threeBeforeWDStr = 'THU';
      twoBeforeWDStr = 'FRI';
      oneBeforeWDStr = 'SAT';
      currentWDStr = 'SUN';
    } else if (fiveBeforeWD == -2) {
      fiveBeforeWDStr = 'WED';
      fourBeforeWDStr = 'THU';
      threeBeforeWDStr = 'FRI';
      twoBeforeWDStr = 'SAT';
      oneBeforeWDStr = 'SUN';
      currentWDStr = 'MON';
    } else if (fiveBeforeWD == -1) {
      fiveBeforeWDStr = 'THU';
      fourBeforeWDStr = 'FRI';
      threeBeforeWDStr = 'SAT';
      twoBeforeWDStr = 'SUN';
      oneBeforeWDStr = 'MON';
      currentWDStr = 'TUE';
    } else if (fiveBeforeWD == 0) {
      fiveBeforeWDStr = 'FRI';
      fourBeforeWDStr = 'SAT';
      threeBeforeWDStr = 'SUN';
      twoBeforeWDStr = 'MON';
      oneBeforeWDStr = 'TUE';
      currentWDStr = 'WED';
    } else if (fiveBeforeWD == 1) {
      fiveBeforeWDStr = 'SAT';
      fourBeforeWDStr = 'SUN';
      threeBeforeWDStr = 'MON';
      twoBeforeWDStr = 'TUE';
      oneBeforeWDStr = 'WED';
      currentWDStr = 'THU';
    } else if (fiveBeforeWD == 2) {
      fiveBeforeWDStr = 'SUN';
      fourBeforeWDStr = 'MON';
      threeBeforeWDStr = 'TUE';
      twoBeforeWDStr = 'WED';
      oneBeforeWDStr = 'THU';
      currentWDStr = 'FRI';
    }
  }

  List<LineChartBarData> linesBarData1() {
    // First line
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 1.5),
        FlSpot(5, 1.4),
        FlSpot(7, 3.4),
        FlSpot(10, 2),
      ],
      isCurved: true,
      colors: [
        const Color(0xffff91a4),
      ],
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    final LineChartBarData lineChartBarData2 = LineChartBarData(
      // Second line
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 2.8),
        FlSpot(7, 1.2),
        FlSpot(10, 2.8),
        FlSpot(12, 2.6),
        FlSpot(13, 3.9),
      ],
      isCurved: true,
      colors: [
        const Color(0xffad268e),
      ],
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        const Color(0x00aa4cfc),
      ]),
    );
    final LineChartBarData lineChartBarData3 = LineChartBarData(
      // Third line
      spots: [
        FlSpot(1, 2.8),
        FlSpot(3, 1.9),
        FlSpot(6, 3),
        FlSpot(10, 1.3),
        FlSpot(13, 2.5),
      ],
      isCurved: true,
      colors: const [
        Color(0xffc22741),
      ],
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    return [
      lineChartBarData1,
      lineChartBarData2,
      lineChartBarData3,
    ];
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        // Chart data titles
        bottomTitles: SideTitles(
          // x-axis titles
          showTitles: true,
          interval: 1,
          reservedSize: 10,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          margin: 5,
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '$fiveBeforeWDStr';
              case 3:
                return '$fourBeforeWDStr';
              case 5:
                return '$threeBeforeWDStr';
              case 7:
                return '$twoBeforeWDStr';
              case 9:
                return '$oneBeforeWDStr';
              case 11:
                return '$currentWDStr';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          //y-axis titles
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0';
              case 1:
                return '20';
              case 2:
                return '40';
              case 3:
                return '60';
              case 4:
                return '80';
              case 5:
                return '100';
              case 6:
                return '120';
              case 7:
                return '140';
              case 8:
                return '160';
              case 9:
                return '180';
              case 10:
                return 'mmHg';
            }
            return '';
          },
          margin: 10,
          reservedSize: 40,
        ),
      ),
      borderData: FlBorderData(
        //Chart border
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 14,
      maxY: 10,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LineChart(
        sampleData1(),
        swapAnimationDuration: const Duration(milliseconds: 250),
      ),
    );
  }
}
