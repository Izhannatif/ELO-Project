import 'package:elo_games/assets.dart';
import 'package:elo_games/ratingPage.dart';
import 'package:flutter/material.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  void sortedList() {
      bool sorted = false;
      GameRating temp;
      while (!sorted) {
        sorted = true;
        for (int i = 0; i < listOfGames.length - 1; i++) {
          if (listOfGames[i].rating < listOfGames[i + 1].rating) {
            temp = listOfGames[i];
            listOfGames[i] = listOfGames[i + 1];
            listOfGames[i + 1] = temp;
            sorted = false;
          }
        }
      }
    }
  @override
  Widget build(BuildContext context) {
     
    
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1567095751004-aa51a2690368?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'),
              colorFilter: ColorFilter.mode(Colors.black87, BlendMode.darken),
              fit: BoxFit.fill)),
      child: ListView.builder(
        itemCount: listOfGames.length,
        itemBuilder: (BuildContext context, int index) {
          sortedList();
          double rating = (listOfGames[index].rating)/1000;
          return Column(children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(listOfGames[index].rndImg),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    listOfGames[index].name.toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    '$rating',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.white24,
              indent: 30,
              endIndent: 30,
            ),
          ]);
        },
      ),
    );
  }
}
