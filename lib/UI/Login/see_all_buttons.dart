import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SeeAllButton extends StatelessWidget {
  final List<dynamic> seeAllList;

  SeeAllButton(this.seeAllList); // this constructor accepts a function

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SeeAllPage(seeAllList)),
        );
      },
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

class SeeAllPage extends StatelessWidget {
  final seeAllList;
  final String backArrow = 'assets/icons/backarrow.svg';

  SeeAllPage(this.seeAllList);

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
        body: SingleChildScrollView(),
      ),
    );
  }
}
