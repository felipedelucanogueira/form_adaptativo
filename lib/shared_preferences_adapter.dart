import 'package:form_adaptativo/internal_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesAdapter extends InternalStorageAdapter {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> saveUser(String name, String surname) async {
    final internalPref = await _prefs;
    internalPref.setString('name', name);
    internalPref.setString('surname', surname);
    print('Dados Seguros');
  }

  Future<String> getFullName() async {
    final String? name = await getName();
    final String? surname = await getSurname();

    if ((name != null) && (surname != null)) {
      return name + ' ' + surname;
    } else {
      return 'Usuário nao Salvo';
    }
  }

  Future<String?> getName() async {
    final internalPref = await _prefs;
    return internalPref.getString('name');
  }

  Future<String?> getSurname() async {
    final internalPref = await _prefs;
    return internalPref.getString('surname') ?? '';
  }

  @override
  void deleteUser(String name, String surname) {
    // TODO: implement deleteUser
  }
}
