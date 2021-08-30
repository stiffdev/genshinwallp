import 'dart:io';

import 'package:flutter/material.dart';
import 'package:genshinwallp/src/pages/pagesmenu/map/map_card.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.blue[800],
            child: CustomScrollView(slivers: [
              _crearAppBar(),
              SliverList(
                  delegate: SliverChildListDelegate([
                SizedBox(height: 10),
                Text(
                  "Map",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway'),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: /*[getTextWidgets(secondProvider.features)]*/
                        [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/mapdetail',
                              arguments: 'inazuma');
                        },
                        child: Opacity(
                          opacity: 0.9,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40.0),
                                  bottomRight: Radius.circular(40.0),
                                  topLeft: Radius.circular(40.0),
                                  bottomLeft: Radius.circular(40.0)),
                              color: Colors.black,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('Inazuma',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Raleway')),
                                Image(
                                    image: AssetImage('lib/src/assets/ina.png'),
                                    width:
                                        MediaQuery.of(context).size.width / 6)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 20)),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/mapdetail',
                              arguments: 'mihoyo');
                        },
                        child: Opacity(
                          opacity: 0.9,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40.0),
                                  bottomRight: Radius.circular(40.0),
                                  topLeft: Radius.circular(40.0),
                                  bottomLeft: Radius.circular(40.0)),
                              color: Colors.black,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('Teyvat',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Raleway')),
                                Image(
                                    image: AssetImage('lib/src/assets/map.png'),
                                    width:
                                        MediaQuery.of(context).size.width / 6),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]))
            ])));
  }

  Widget _crearAppBar() {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          '',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Raleway'),
          textAlign: TextAlign.center,
        ),
        background: FadeInImage(
          image: AssetImage('lib/src/assets/gensihoriz.jpeg'),
          placeholder: AssetImage('lib/src/assets/gensihoriz.jpeg'),
          fadeInDuration: Duration(milliseconds: 1000),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
