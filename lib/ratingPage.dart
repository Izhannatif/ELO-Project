// ignore_for_file: file_names

import 'dart:math';

import 'package:elo_games/assets.dart';
import 'package:flutter/material.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({Key? key}) : super(key: key);

  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  static List<GameRating> gamesList = listOfGames;
  String imagePath1 = gamesList[0].rndImg;
  String imagePath2 = gamesList[1].rndImg;
  String name1 = gamesList[0].name;
  String name2 = gamesList[1].name;
  double p1Rating = gamesList[0].rating;
  double p2Rating = gamesList[1].rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1567095751004-aa51a2690368?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'),
              colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
              fit: BoxFit.fill)),
      child: ListView(padding: const EdgeInsets.only(top: 150), children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                      ),
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width / 3,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            elo_Algorithm(true);
                            shuffle();
                          });
                        },
                        child: Image.asset(
                          imagePath1,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      name1.toUpperCase(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 5,
                  child: Center(
                    child: Column(
                      children: const [
                        Text(
                          "OR",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1),
                        ),
                        Text(
                          "Tap to vote!",
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 19,
                              letterSpacing: 1),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                      ),
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width / 3,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            elo_Algorithm(false);

                            shuffle();
                          });
                        },
                        child: Image.asset(
                          imagePath2,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      name2.toUpperCase(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            shuffleButton(),
          ],
        ),
      ]),
    );
  }

  void shuffle() {
    setState(() {
      gamesList.shuffle();
      name1 = gamesList[0].name;
      imagePath1 = gamesList[0].rndImg;
      p1Rating = gamesList[0].rating;

      name2 = gamesList[1].name;
      imagePath2 = gamesList[1].rndImg;
      p2Rating = gamesList[1].rating;
    });
    print("Shuffled");
  }

  shuffleButton() {
    return GestureDetector(
      onTap: () {
        shuffle();
      },
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
            color: Colors.red.shade900,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text(
                "Change",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    letterSpacing: 1),
              ),
              Icon(
                Icons.change_circle_outlined,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
  // ALGORITHMMMM HEREEEEEEEEEEE!!!!!!!!!! \\

  probablity(double r1, double r2) {
    return (1.0 * 1.0 / (1 + 1.0 * pow(10, 1.0 * ((r1 - r2) / 400))));
  }

  elo_Algorithm(bool d) {
    //double img1Pb = (1.0 / (1.0 + pow(10, ((p1Rating - p2Rating) / 400))));
    //double img2Pb = (1.0 / (1.0 + pow(10, ((p2Rating - p1Rating) / 400))));
    int k = 100;
    double ra = p1Rating;
    double rb = p2Rating;

    double pb = probablity(ra, rb);
    double pa = probablity(rb, ra);

    if (d == true) {
      setState(() {
        ra = ra + k * (1 - pa);
        rb = rb + k * (0 - pb);
      });
    } else {
      setState(() {
        ra = ra + k * (0 - pa);
        rb = rb + k * (1 - pb);
      });
    }
    setState(() {
      p1Rating = ra;
      p2Rating = rb;
    });
    print('updated rating');

    print("rating of image 1: " +
        '$p1Rating' +
        " Name " +
        name1 +
        " Probablity:" +
        '${pa}');
    print("rating of image 2: " +
        '$p2Rating' +
        " Name " +
        name2 +
        " Probablity:" +
        '${pa}');
  }
}
