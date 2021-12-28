// ignore_for_file: file_names

import 'package:elo_games/leadeboard.dart';
import 'package:elo_games/ratingPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List pages = [
    RatingPage(),
    LeaderBoard(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (int index) {
              setState(() {
                selectedIndex = index;
              });
            },
            backgroundColor: Colors.transparent.withOpacity(1),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white30,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.leaderboard), label: "")
            ]),
        appBar: AppBar(
          centerTitle: true,
          title:  Text("ELO Rating Algorithm".toUpperCase()),
            backgroundColor: Colors.transparent.withOpacity(1),
        ),
        body: pages[selectedIndex]);
  }
}
