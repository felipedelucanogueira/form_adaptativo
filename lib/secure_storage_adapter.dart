import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:form_adaptativo/internal_storage.dart';

class SecureStorageAdapter extends InternalStorageAdapter {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<void> saveUser(String name, String surname) async {
    await secureStorage.write(key: 'name', value: name);
    await secureStorage.write(key: 'surname', value: surname);
    print('Dados Seguros');
  }

  Future<String> getFullName() async {
    String? name = await secureStorage.read(key: 'name');
    String? surname = await secureStorage.read(key: 'surname');

    if ((name != null) && (surname != null)) {
      return name + ' ' + surname;
    } else {
      return 'Dados não Seguros';
    }
  }

  @override
  Future<String?> getName() async {
    final result = await secureStorage.read(key: 'name') ?? '';
    return result;
  }

  @override
  Future<String?> getSurname() async {
    final result = await secureStorage.read(key: 'surname') ?? '';
    return result;
  }

  @override
  void deleteUser(String name, String surname) {
    // TODO: implement deleteUser
  }
}
