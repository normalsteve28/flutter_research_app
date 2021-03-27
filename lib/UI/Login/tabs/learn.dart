import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../assets.dart'; // Contains svg icons
import '../see_all_buttons.dart';
import 'learn_assets/articlelist.dart';
import 'learn_assets/articles.dart';

class Learn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            AppBarwithIcon(), // App Bar with Text and Icon Buttons (search, "Learn", and bookmark button)
        backgroundColor: Color(0xffFE7575),
      ),
      body: LearnPage(), // List of articles
      backgroundColor: Colors.pink[50],
    );
  }
}

class AppBarwithIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            alignment: Alignment.centerLeft,
            icon: SvgPicture.asset(search),
            onPressed: null,
          ),
          Text(
            'Learn',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Montserrat',
            ),
          ),
          IconButton(
            alignment: Alignment.centerRight,
            icon: SvgPicture.asset(bookmarks),
            onPressed: null,
          )
        ],
      ),
    );
  }
}

class LearnPage extends StatefulWidget {
  @override
  _LearnPageState createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleHandler(
                    "First Aid for Heart Attack",
                    articles[0],
                    images[0],
                    imageSource[0],
                  ),
                ),
              );
            },
            child: Container(
              //This container is the "First Aid for Heart Attack"
              width: 262,
              height: 248,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 249,
                        height: 248,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(36),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.only(
                          bottom: 59,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 249,
                              height: 189,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(36),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.white, Color(0x00ffffff)],
                                ),
                              ),
                              child: Padding(
                                // Image
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(heartAttack),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 5,
                    top: 197,
                    child: SizedBox(
                      width: 256,
                      height: 33,
                      child: Text(
                        "First Aid for Heart Attack",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Heart Health 101",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SeeAllButton(null)
            ],
          ),
          ArticleList()
        ],
      ),
    );
  }
}
