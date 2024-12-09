import 'package:shared_preferences/shared_preferences.dart';

class SoporteSel {
  factory SoporteSel() {
    return _instancia;
  }
  SoporteSel._();
  static final SoporteSel _instancia = SoporteSel._();
  SharedPreferences? _prefs;
  initSopSel() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String get soporte {
    return _prefs?.getString('soporte') ?? '';
  }

  set soporte(String valor) {
    _prefs?.setString('soporte', valor);
  }
}
