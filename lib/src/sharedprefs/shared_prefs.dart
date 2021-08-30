import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  int get rateSession {
    return _prefs.getInt('rateSession') ?? 0;
  }

  set rateSession(int value) {
    _prefs
        .setInt('rateSession', value)
        .then((value) => print('changed rateSesstion to $value'));
  }

  int get ratedPrev {
    //save if user rat previously ->0 - not rat
    return _prefs.getInt('ratedPrev') ?? 0;
  }

  set ratedPrev(int value) {
    _prefs
        .setInt('ratedPrev', value)
        .then((value) => print('changed ratedPrev to $value'));
  }

  int get pol1 {
    return _prefs.getInt('pol1') ?? 1;
  }

  set pol1(int value) {
    _prefs.setInt('pol1', value).then((value) => print('changed p1 to $value'));
  }

  int get pol2 {
    return _prefs.getInt('pol2') ?? 1;
  }

  set pol2(int value) {
    _prefs.setInt('pol2', value).then((value) => print('changed p2 to $value'));
  }

  // GET y SET de la última página
  String get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'home';
  }

  set ultimaPagina(String value) {
    _prefs.setString('ultimaPagina', value);
  }
}
