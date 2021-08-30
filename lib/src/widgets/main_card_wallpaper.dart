import 'dart:math';

import 'package:flutter/material.dart';
import 'package:genshinwallp/src/pages/pagesmenu/save/save_wall_page.dart';
import 'package:genshinwallp/src/widgets/wallpaper.dart';

class MainCardWallpaper extends StatelessWidget {
  String image;
  MainCardWallpaper({required this.image});

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
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
            //Navigator.pushNamed(context, 'detalle', arguments: peliculas[index]);
            context,
            '/saveWallp',
            arguments: image);
      }
      //  MaterialPageRoute(builder: (context) => SaveWallpaperPage( image: this.image,))
      ,
      child: AspectRatio(
        aspectRatio: 1 / y,
        child: Container(
          margin: EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(this.image),
              )),
        ),
      ),
    );
  }
}
