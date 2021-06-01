import 'package:shared_preferences/shared_preferences.dart';


class InternalStorage{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void saveUser(String name, String surname) async {
    final internalPref = await _prefs;
    internalPref.setString('name', name);
    internalPref.setString('surname', surname);
    print('Dados Salvos');

  }

  Future <String> getUserFullName() async {
    final internalPref = await _prefs;
    String? name = internalPref.getString('name');
    String? surname = internalPref.getString('surname');

    if((name != null) && (surname != null)){
    return name + ' ' + surname;
    }else{
      return 'Usuário nao Salvo';
    }
  }
}