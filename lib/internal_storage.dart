//import 'package:form_adaptativo/user.dart';

abstract class InternalStorageAdapter {
  void saveUser(String name, String surname);
  Future<String> getFullName();
  void deleteUser(String name, String surname);
  Future<String?> getName();
  Future<String?> getSurname();
}
