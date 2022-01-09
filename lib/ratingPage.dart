// ignore_for_file: file_names, avoid_print, prefer_adjacent_string_concatenation

import 'dart:math';

import 'package:elo_games/assets.dart';
import 'package:flutter/material.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({Key? key}) : super(key: key);

  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  String imagePath1 = listOfGames[0].rndImg;
  String imagePath2 = listOfGames[1].rndImg;
  String name1 = listOfGames[0].name;
  String name2 = listOfGames[1].name;
  double p1Rating = listOfGames[0].rating;
  double p2Rating = listOfGames[1].rating;
  double newRatingA = 0;
  double newRatingB = 0;

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
                            shuffle();
                            scoreCalculator(true);
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
                    Column(
                      children: [
                        Text(
                          name1.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1),
                        ),
                        // Text(
                        //   '$p1Rating',
                        //   style: const TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 22,
                        //       fontWeight: FontWeight.bold,
                        //       letterSpacing: 1),
                        // ),
                      ],
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
                            
                            scoreCalculator(false);
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
                    Column(
                      children: [
                        Text(
                          name2.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1),
                        ),
                        // Text(
                        //   '$p2Rating',
                        //   style: const TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 22,
                        //       fontWeight: FontWeight.bold,
                        //       letterSpacing: 1),
                        // ),
                      ],
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
   //Fisher-yates shuffling Algorithm.
    int index;
    GameRating temp;
    Random random = Random();
    for (int i = listOfGames.length - 1; i > 0; i--) {
      index = random.nextInt(i + 1);
      temp = listOfGames[index];
      listOfGames[index] = listOfGames[i];
      listOfGames[i] = temp;
    }
   //Fisher-yates shuffling Algorithm.
    setState(() {
      //Here we are declaring the shuffled list into new variable through which we will call them.
      name1 = listOfGames[0].name;
      imagePath1 = listOfGames[0].rndImg;
      p1Rating = listOfGames[0].rating;

      name2 = listOfGames[1].name;
      imagePath2 = listOfGames[1].rndImg;
      p2Rating = listOfGames[1].rating;
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
            borderRadius: const BorderRadius.all(Radius.circular(15))),
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

  scoreCalculator(bool d) {
    double expectedA = ((1) / (1 + pow(10, ((p2Rating - p1Rating) / 400))));
    double expectedB = ((1) / (1 + pow(10, ((p1Rating - p2Rating) / 400))));
    print(expectedA);
    print(expectedB);
    print(expectedA + expectedB);
    print(d);
    if (d == true) {
      setState(() {
        p1Rating =
            listOfGames[0].rating = p1Rating + (320 * (1 - expectedA)).round();
        p2Rating =
            listOfGames[1].rating = p2Rating + (320 * (0 - expectedB)).round();
      });
    } else if (d == false) {
      setState(() {
        p1Rating =
            listOfGames[0].rating = p1Rating + (320 * (0 - expectedA)).round();
        p2Rating =
            listOfGames[1].rating = p2Rating + (320 * (1 - expectedB)).round();
      });
    }

    print('updated rating');

    print("rating of image 1: " +
        '$p1Rating' +
        " Name " +
        name1 +
        " Expected A:" +
        '$expectedA');
    print("rating of image 2: " +
        '$p2Rating' +
        " Name " +
        name2 +
        " Expected B:" +
        '$expectedB');
  }
}
