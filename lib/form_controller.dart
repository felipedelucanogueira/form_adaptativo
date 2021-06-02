import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:form_adaptativo/form_model.dart';

class FormController {
  final model = FormModel();
  final _formModelState = StreamController<FormModel>();

  Stream<FormModel> get stateStream => _formModelState.stream;


  void initSetup() async {
    model.fecthName();
    _formModelState.add(model);

  }

  String? get name => model.name;
  String? get surname => model.surname;
  Future<String> get fullName => model.getFullName();

  void set nome(String nome) => model.name = nome;

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
}