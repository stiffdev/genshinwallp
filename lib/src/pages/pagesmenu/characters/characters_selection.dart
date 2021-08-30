import 'package:flutter/material.dart';
import 'package:genshinwallp/src/widgets/back_button.dart';
import 'package:genshinwallp/src/widgets/character_card.dart';
import 'package:genshinwallp/src/widgets/main_card.dart';

class CharacterSelectionPage extends StatelessWidget {
  const CharacterSelectionPage({Key? key}) : super(key: key);

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
                      child: Text("Select character",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway')),
                    ),
                  ),
                ],
              ),
              Expanded(child: _gridViewDemo(context))
            ],
          ),
        ),
      ),
    );
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

Widget _gridViewDemo(BuildContext context) {
  return Container(
    child: GridView(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 20.0,
            childAspectRatio: 0.7),
        children: __gridViewChildCustom(context)),
  );
}

List<Widget> __gridViewChildCustom(BuildContext context) {
  //final provider = new BgProvider();

  List<Widget> children = [];
  for (int index = 1; index < 31; index++) {
    children.add(GestureDetector(
        onTap: () {
          Navigator.pushNamed(
              //Navigator.pushNamed(context, 'detalle', arguments: peliculas[index]);
              context,
              '/selbg',
              arguments: 'lib/src/assets/character/sk$index.png');
        },
        child: CharacterCard(image: 'lib/src/assets/character/sk$index.png')));
  }
  return children;
}
