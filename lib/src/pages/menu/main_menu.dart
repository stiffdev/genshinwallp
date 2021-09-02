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
      image: AssetImage("lib/src/assets/bg.png"),
      fit: BoxFit.cover,
    ),
  );
}
