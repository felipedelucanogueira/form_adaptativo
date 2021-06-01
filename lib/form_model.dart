import 'package:form_adaptativo/internal_storage.dart';

class FormModel{
  String? name;
  String? surname;



  // set setName(String valor){
  //   this.name = valor;
  //
  // }

  final InternalStorage internalStorage = InternalStorage();

  void saveUser(){
    if (name == null) return;
    if (surname == null) return;
   //internalStorage.saveUser(name!, surname!);
   internalStorage.secureUser(name!, surname!);

  }

  Future<String> getFullName(){
  //  return internalStorage.getUserFullName();
    return internalStorage.getSecureFullName();
  }
}