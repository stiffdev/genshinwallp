import 'dart:math';

import 'package:flutter/material.dart';

class CharacterCard extends StatelessWidget {
  String image;
  CharacterCard({required this.image});

  static double getRandom() {
    final double y = Random().nextInt(250) / 100;
    if (y < 1.2)
      return getRandom();
    else
      return y;
  }

  final double y = getRandom();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / y,
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            //borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
          fit: BoxFit.fitHeight,
          image: AssetImage(this.image),
        )),
      ),
    );
  }
}
