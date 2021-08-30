import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class CardMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String image = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Map'),
        backgroundColor: Colors.indigoAccent,
      ),
      body: Container(
        color: Colors.black,
        margin: EdgeInsets.only(bottom: 15),
        child:
            PhotoView(imageProvider: AssetImage('lib/src/assets/$image.png')),
      ),
    );
  }
}
