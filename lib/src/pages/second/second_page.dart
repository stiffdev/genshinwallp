import 'package:flutter/material.dart';
import 'package:genshinwallp/src/pages/second/second_provider.dart';
import 'package:genshinwallp/src/widgets/my_button.dart';

class SecondPage extends StatelessWidget {
  final secondProvider = new SecondProvider();

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
              "Features",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 37,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway'),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
            Column(
              children: [getTextWidgets(secondProvider.features)],
            ),
            SizedBox(height: 50),
            Container(
              padding: EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/menu2');
                },
                child: MyButton(data: 'Next'),
              ),
            ),
          ]),
        ),
        // )
      ]),
    ));
  }

  Widget getTextWidgets(List<String> strings) {
    return Container(
      //padding: EdgeInsets.all(56.0),
      child: new Column(
        children: strings
            .map((item) => Container(
                  padding: EdgeInsets.all(20.0),
                  child: new Text(
                    ' - ' + item,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway'),
                    textAlign: TextAlign.center,
                  ),
                ))
            .toList(),
      ),
    );
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
          fadeInDuration: Duration(milliseconds: 2000),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
