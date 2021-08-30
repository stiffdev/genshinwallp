import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:genshinwallp/src/model/Tip.dart';

class TipsProvider {
  int _popularesPage = 0;

  List<Tip> _tips = [];

  bool cargando = false;

  Future<List<Tip>> processResponse() async {
    //final resp = await http.get(url); //le digo que se espere a que haga la solicitud

    var jsonText = await rootBundle.loadString('lib/src/assets/tips.json');

    final decodedData = json.decode(
        jsonText); //toma el string de la respuesta y lo transforma en mapa

    final tips = new Tips.fromJsonList(decodedData['tips']);

    //print(peliculas.items[0].title);

    return tips.items;
  }
}
