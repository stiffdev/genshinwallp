import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  String _heroe = 'Capitán América';
  Color colorBase = Colors.blue;

  bool _showResources = false;

  String get heroe {
    return _heroe;
  }

  bool get showResources {
    return _showResources;
  }

  set showResources(bool varia) {
    this._showResources = varia;

    notifyListeners();
  }

  void changeStat() {
    if (_showResources == true) {
      showResources = false;
    } else {
      showResources = true;
    }
  }

  set heroe(String nombre) {
    this._heroe = nombre;

    this.colorBase = (nombre == 'Ironman') ? Colors.red : Colors.blue;

    notifyListeners();
  }
}
