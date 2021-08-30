import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /* appBar: AppBar(
          title: Text('Componentes'),
        ),*/
        body: Container(
            decoration: _widgetBackground(),
            child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    //MediaQuery.of(context).size.width
                    SizedBox(height: 30),
                    Stack(
                      alignment: Alignment.topLeft,
                      children: <Widget>[
                        Text("Back"),
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  ],
                ))));
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

  //

  //return CardSwiper(peliculas: images);
}
