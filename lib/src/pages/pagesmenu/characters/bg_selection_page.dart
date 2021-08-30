import 'package:flutter/material.dart';
import 'package:genshinwallp/src/providers/bg_provider.dart';
import 'package:genshinwallp/src/widgets/back_button.dart';
import 'package:genshinwallp/src/widgets/main_card.dart';
import 'package:genshinwallp/src/widgets/wallpaper.dart';

class BgSelectionPage extends StatefulWidget {
  BgSelectionPage({Key? key}) : super(key: key);

  @override
  _BgSelectionPageState createState() => _BgSelectionPageState();
}

class _BgSelectionPageState extends State<BgSelectionPage> {
  @override
  void initState() {
    //populateColumns();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String skin = ModalRoute.of(context)!.settings.arguments as String;
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
                    child: Text("Select background",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway')),
                  ),
                ),
              ],
            ),
            Expanded(child: _gridViewDemo(context, skin))
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

Widget _gridViewDemo(BuildContext context, String skin) {
  return Container(
    child: GridView(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 20.0,
            childAspectRatio: 0.7),
        children: __gridViewChildCustom(context, skin)),
  );
}

List<Widget> __gridViewChildCustom(BuildContext context, String skin) {
  final provider = new BgProvider();

  List<Widget> children = [];
  for (int index = 1; index < provider.backgrounds.length; index++) {
    children.add(GestureDetector(
        onTap: () {
          Navigator.pushNamed(
              //Navigator.pushNamed(context, 'detalle', arguments: peliculas[index]);
              context,
              '/skinWallp',
              arguments: ScreenArguments(skin, provider.backgrounds[index]));
        },
        child: MainCard(image: provider.backgrounds[index])));
  }
  return children;
}

List<Widget> __gridMainView() {
  List<Widget> children = [];
  for (int index = 1; index < 100; index++) {
    children.add(MainCard(
        image:
            "https://curiosfera-ciencia.com/wp-content/uploads/2021/04/caracteristicas-de-las-hojas.jpg"));
  }
  return children;
}
