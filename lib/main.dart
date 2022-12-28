import 'package:flutter/material.dart';
import 'package:tic_tac_toe/widget/palyTile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Color.fromARGB(255, 150, 208, 255),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List tile = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
  ];

  int lastMove = -1; 

  bool turn = true;

  String gameStatus = "Play";

  void clicked(int image) {
    setState(() {
      lastMove = image;
      if (turn) {
        tile[image] = "x";
      } else {
        tile[image] = "o";
      }
      turn = !turn;
    });

    if (tile[0] != "" &&
        tile[1] != "" &&
        tile[2] != "" &&
        tile[3] != "" &&
        tile[4] != "" &&
        tile[5] != "" &&
        tile[6] != "" &&
        tile[7] != "" &&
        tile[8] != "") {
      setState(() {
        gameStatus = "Draw";
      });
    }

    if ((tile[0] == tile[1] && tile[1] == tile[2] && tile[0] != "") ||
        (tile[3] == tile[4] && tile[4] == tile[5] && tile[3] != "") ||
        (tile[6] == tile[7] && tile[7] == tile[8] && tile[6] != "") ||
        (tile[0] == tile[3] && tile[3] == tile[6] && tile[0] != "") ||
        (tile[1] == tile[4] && tile[4] == tile[7] && tile[1] != "") ||
        (tile[2] == tile[5] && tile[5] == tile[8] && tile[2] != "") ||
        (tile[0] == tile[4] && tile[4] == tile[8] && tile[0] != "") ||
        (tile[2] == tile[4] && tile[4] == tile[6] && tile[2] != "")) {
      if (!turn) {
        setState(() {
          gameStatus = "X is winner";
        });
      } else {
        setState(() {
          gameStatus = "O is winner";
        });
      }
    }
  }

  void resetData() {
    setState(() {
      tile = [
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
      ];

      turn = true;

      gameStatus = "Play";
    });
  }


  void undoGame(){
    setState(() {
      tile[lastMove] = "";
      lastMove = -1;
      turn = !turn;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBarHeight = AppBar().preferredSize.height;
    final deviceSize = MediaQuery.of(context).size;

    final deviceHeight = deviceSize.height - appBarHeight;
    final deviceWidth = deviceSize.width;

    // final tempBorder = BoxDecoration(
    //   border: Border.all(color: Colors.red, width: 5),
    // );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Container(
        color: Theme.of(context).accentColor,
        height: deviceHeight,
        width: deviceWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Text(
                gameStatus,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 60,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              ),
            ),
            PlayTile(
                deviceWidth: deviceWidth,
                tile: tile,
                gameStatus: gameStatus,
                clicked: clicked),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 60,
                  width: deviceWidth/2 - 15,
                  child: ElevatedButton(
                    onPressed: () {
                      (gameStatus == 'Play' && lastMove != -1) ? undoGame():null;
                    },
                    child: const Text(
                      "Undo",
                      style: TextStyle(fontSize: 23, color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: deviceWidth/2 - 15,
                  child: ElevatedButton(
                    onPressed: () {
                      gameStatus != 'Play' ? resetData() : null;
                    },
                    child: const Text(
                      "Reset",
                      style: TextStyle(fontSize: 23, color: Colors.black),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
