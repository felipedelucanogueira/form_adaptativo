abstract class InternalStorageAdapter {
  Future<void> saveUser(String name, String surname);
  Future<String> getFullName();
  Future<String?> getName();
  Future<String?> getSurname();
}
