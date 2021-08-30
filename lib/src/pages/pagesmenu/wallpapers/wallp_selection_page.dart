import 'package:flutter/material.dart';
import 'package:genshinwallp/src/providers/bg_provider.dart';
import 'package:genshinwallp/src/widgets/back_button.dart';
import 'package:genshinwallp/src/widgets/main_card_wallpaper.dart';

class WallpaperSelection extends StatelessWidget {
  const WallpaperSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      decoration: _widgetBackground(),
      child: SafeArea(
        //child: _gridViewDemo(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MainBackButton(),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text("Select Wallpapers",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway')),
                  ),
                ),
              ],
            ),
            Expanded(child: _gridViewDemo())
          ],
        ),
      ),
    ));
  }
}

BoxDecoration _widgetBackground() {
  return BoxDecoration(
    image: DecorationImage(
      image: NetworkImage(
          "https://preview.redd.it/dwgetie8y5971.png?auto=webp&s=f1c930259ac1cd143a024df0152ba2caabad1d35"),
      fit: BoxFit.cover,
    ),
  );
}

Widget _gridViewDemo() {
  return Container(
    child: GridView(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 20.0,
            childAspectRatio: 0.7),
        children: __gridViewChildCustom()),
  );
}

List<Widget> __gridViewChildCustom() {
  final provider = new BgProvider();

  List<Widget> children = [];
  for (int index = 0; index < provider.images.length; index++) {
    children.add(MainCardWallpaper(image: provider.images[index]));
  }
  return children;
}
