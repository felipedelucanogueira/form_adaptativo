abstract class InternalStorageAdapter{
  void saveUser(String name , String surname);
  Future<String> getFullName();
  Future<String?> getName();
  Future<String?> getSurname();
}