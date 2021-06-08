

import 'package:form_adaptativo/form_model.dart';
import 'package:form_adaptativo/user.dart';

class FormController{
  final model = FormModel();

  String? get name => model.name;
  String? get surname => model.surname;
  Future<String> get fullName => model.getFullName();


  void onChangeName(String name){
    model.name = name;
}
void onChangeSurname(String surname){
    model.surname = surname;
}

  // void onChange(String valor){
  //   model.setName = valor;
  //
  // }
 // Future<String> get fullName => model.getUserFullName();

  void saveUser(){
    model.saveUser();

  }
  void deleteUser(){
    model.deleteUser();
  }

}