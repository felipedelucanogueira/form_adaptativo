import 'package:form_adaptativo/internal_storage.dart';
import 'package:form_adaptativo/secure_storage_adapter.dart';
import 'package:form_adaptativo/shared_preferences_adapter.dart';

class FormModel{
  String? name;
  String? surname;

  // set setName(String valor){
  //   this.name = valor;
  //
  // }
  final InternalStorageAdapter internalStorage;

  FormModel({InternalStorageAdapter? internalStorageAdapter}) : internalStorage = internalStorageAdapter ?? SharedPreferencesAdapter();

  void saveUser(){
    if (name == null) return;
    if (surname == null) return;

    internalStorage.saveUser(name!, surname!);
  }

  Future<String> getFullName(){
    return internalStorage.getFullName();

  }
}