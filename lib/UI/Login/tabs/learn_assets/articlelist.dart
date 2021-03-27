import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'articles.dart';

class ArticleList extends StatelessWidget {
  final List<Widget> articleList = [
    ArticleCard(
        "What is hypertension?", articles[1], images[1], null, articleIcons[1]),
    ArticleCard("Symptoms and causes of hypertension", articles[2], images[2],
        null, articleIcons[2]),
    ArticleCard("What is blood pressure?", articles[3], images[3], null,
        articleIcons[3]),
    ArticleCard(
        "What is heart rate?", articles[4], images[4], null, articleIcons[4]),
    ArticleCard("How to stay heart healthy", articles[5], images[5], null,
        articleIcons[5])
  ];
  /* 
  The list above is the list of Article Cards.
  Article Cards handle arguments of the title
  */
  @override
  Widget build(BuildContext context) {
    // This builds the list view out of the articleList and makes it scrollable
    return Container(
      child: Expanded(
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: articleList.length,
          itemBuilder: (context, index) {
            return articleList[index];
          },
        ),
      ),
    );
  }
}

class ArticleCard extends StatelessWidget {
  /*
  This handles the article cards in the Learn tab.
  It handles the title, the article, the image, and the source of the image for the article.
  This is done to shorten the code.
   */
  final String title;
  final String article;
  final String img;
  final String imgSource;
  final String articleIcon;

  ArticleCard(
      this.title, this.article, this.img, this.imgSource, this.articleIcon);

  @override
  Widget build(BuildContext context) {
    return Card(
        shadowColor: Colors.transparent,
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticleHandler(
                  title,
                  article,
                  img,
                  imgSource,
                ),
              ),
            );
          },
          child: Row(
            children: [
              Container(
                // This container is to hold the image of the article card.
                margin: EdgeInsets.only(top: 5, bottom: 5, left: 10),
                width: 120,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color: Color(0xfffe7575),
                ),
                child: articleIcon != null
                    ? Padding(
                        padding: const EdgeInsets.all(0.00000000001),
                        child: SvgPicture.asset(articleIcon),
                      )
                    : Container(),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      // This text displays the title of the article card.
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class ArticleHandler extends StatelessWidget {
  /*
  This handles the articles themselves. This is the page that shows up
  when you press the article card. This is done to shorten the code.
  */
  final String title;
  final String article;
  final String img;
  final String imgSource;
  final String backArrow = 'assets/icons/backarrow.svg';

  ArticleHandler(this.title, this.article, this.img, this.imgSource);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFEBEB),
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(backArrow),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Container(
        margin: EdgeInsets.all(25),
        alignment: Alignment.topLeft,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  // Displays title of article
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              img != null
                  ? Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Image.asset(img),
                    )
                  : Container(), // Checks if img asset directory is null to see if it should display an image or not
              imgSource !=
                      null // Checks if the image has a source, and displays it if it does
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        "Image from $imgSource",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Container(),
                    ),
              Text(
                // This text displays the body of the article itself.
                article,
                style: TextStyle(
                  fontFamily: "Nunito",
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
