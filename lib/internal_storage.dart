import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class InternalStorage{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

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
  void secureUser(String name , String surname) async{
    await secureStorage.write(key: 'name', value: name);
    await secureStorage.write(key: 'surname', value: surname);
    print('Dados Seguros');


    }
  Future <String> getSecureFullName() async{
    String? name = await secureStorage.read(key: 'name');
    String? surname = await secureStorage.read(key: 'surname');

    if((name != null) && (surname != null)){
      return name + ' ' + surname;
    }else{
      return 'Dados não Seguros';
    }
  }
}