import 'package:flutter/material.dart';

class SaveWpProvider with ChangeNotifier {
  String _heroe = 'Capitán América';
  Color colorBase = Colors.blue;

  bool _showDialog = false;

  bool _canRate = false;

  String get heroe {
    return _heroe;
  }

  bool get canRate {
    return _canRate;
  }

  set canRate(bool varia) {
    this._canRate = varia;

    notifyListeners();
  }

  bool get showDialog {
    return _showDialog;
  }

  set showDialog(bool varia) {
    this._showDialog = varia;

    notifyListeners();
  }

  void changeStateDialog() {
    if (showDialog == true) {
      showDialog = false;
    } else {
      showDialog = true;
    }
  }

  set heroe(String nombre) {
    this._heroe = nombre;

    this.colorBase = (nombre == 'Ironman') ? Colors.red : Colors.blue;

    notifyListeners();
  }
}
