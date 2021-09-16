import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class CodPage extends StatefulWidget {
  CodPage({Key? key}) : super(key: key);

  @override
  _CodPageState createState() => _CodPageState();
}

class _CodPageState extends State<CodPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("lib/src/assets/bg.png"),
          fit: BoxFit.cover,
        )),
        child: SafeArea(
          //child: _gridViewDemo(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(),
                  Spacer(),
                  Text(
                    "Last Codes",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway'),
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),
                ],
              ),
              FadeInImage(
                  width: MediaQuery.of(context).size.width / 2.7,
                  image: AssetImage('lib/src/assets/gem.png'),
                  placeholder: AssetImage('lib/src/assets/gem.png')),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  decoration: new BoxDecoration(
                      color: Colors.black,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(40.0),
                        topRight: const Radius.circular(40.0),
                        bottomLeft: const Radius.circular(40.0),
                        bottomRight: const Radius.circular(40.0),
                      )),
                  child: FutureBuilder(
                    future: getListCod(context),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return getlist(snapshot.data as List<String>);
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  Future<List<String>> getListCod(BuildContext context) async {
    List<String> list = [];

    final response = await http.Client().get(Uri.parse(
        'https://ffcodes.wordpress.com/2021/09/15/codes-for-genshin/'));

    if (response.statusCode == 200) {
      // print(response.body.toString());
      //Getting the html document from the response
      try {
        var document = parse(response.body);
        var element = document.getElementsByClassName('ulcod');
        var row = element[0].getElementsByTagName('li').toList();

        for (int i = 0; i < row.length; i++) {
          list.add(row[i].text);
        }
        var spnameList =
            row.map((element) => element.attributes['spname']).toList();
        print(row.toString()); //.toList()
        print(spnameList);
        return list;
      } catch (e) {
        print('error getting cod');
        return list;
      }
    } else {
      print('error in response  cod');
      return list;
    }
  }

  ListView getlist(List<String> items) {
    /* return ListView(children: const <Widget>[

      
    ]);*/

    return ListView.builder(
      // Let the ListView know how many items it needs to build.
      itemCount: items.length - 1,
      // Provide a builder function. This is where the magic happens.
      // Convert each item into a widget based on the type of item it is.
      itemBuilder: (context, index) {
        final item = items[index];

        return ListTile(
            title: Text(
          item,
          style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              fontFamily: 'Raleway'),
          textAlign: TextAlign.center,
        ));
      },
    );
  }
}
