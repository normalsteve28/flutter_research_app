import 'package:flutter/material.dart';

// This whole class is the icon that looks like a profile picture default
class ActivityPerson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      width: 44.41,
      height: 44.96,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Color(0xfffe7575),
          width: 5,
        ),
      ),
      child: Container(
        width: 24,
        height: 30.51,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 13,
              height: 13,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffffb0b1),
              ),
            ),
            SizedBox(height: 1),
            Opacity(
              opacity: 0.50,
              child: Container(
                width: 24,
                height: 16.51,
                color: Color(0xffffb0b1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
