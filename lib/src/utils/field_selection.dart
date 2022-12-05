import 'package:shared_preferences/shared_preferences.dart';

class FieldSelection {
  static final FieldSelection _instancia = FieldSelection._();
  factory FieldSelection() {
    return _instancia;
  }
  FieldSelection._();
  SharedPreferences? _prefs;
  initFieldPref() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String get seleccion {
    return _prefs?.getString('seleccion') ?? 'ubicacion';
  }

  set seleccion(String campo) {
    _prefs?.setString('seleccion', campo);
  }
}
