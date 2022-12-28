import 'package:flutter/material.dart';

class PlayTile extends StatelessWidget {
  final double deviceWidth;
  final List tile;
  final String gameStatus;
  Function clicked;

  PlayTile({super.key, required this.deviceWidth, required this.tile, required this.gameStatus, required this.clicked});

  @override
  Widget build(BuildContext context) {
    return Container(
              height: deviceWidth,
              child: GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 1 / 1,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(9, (index) {
                  return Container(
                    margin: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).primaryColor,
                    ),
                    height: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        (tile[index] == "" && gameStatus == "Play")
                            ? clicked(index)
                            : false;
                        print(tile);
                      },
                      child: Container(
                        child: tile[index] != ""
                            ? Image.asset(
                                "assets/images/${tile[index]}Img.png",
                                height: 60,
                              )
                            : Container(),
                      ),
                    ),
                  );
                }),
              ),
            );
  }
}