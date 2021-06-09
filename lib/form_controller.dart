import 'dart:async';

import 'package:form_adaptativo/form_model.dart';
import 'package:form_adaptativo/internal_storage.dart';
import 'package:form_adaptativo/shared_preferences_adapter.dart';
import 'package:form_adaptativo/sql_adapter.dart';

class FormController {
  FormModel model = FormModel();

  // Essa stream controller esta sendo usando para atualizar os campos do formulário
  // usando reatividade, ele é util pois quando os dados do model muda a view
  // nao vai ser atualizada, internamente seu model tem novos dados porém a view
  // não mostra esse dados novos.
  final _streamController = StreamController<FormModel>.broadcast();

  // Adicionei o internalStorage no controller pois creio seja responsibiliadde do
  // controller atualizar os dados
  final InternalStorageAdapter internalStorage = SQLAdapter();

  void initSetup() async {
    // Vc poderia fazer um função para pegar um FormModel, ao invés de pegar o nome, surname etc.
    final nameValue = await internalStorage.getName();
    final surnameValue = await internalStorage.getSurname();

    final newModel = FormModel(name: nameValue, surname: surnameValue);

    // Aq eu add um novo valor atualizado na stream
    _streamController.sink.add(newModel);
    model = newModel;
  }

  //Internamente no controller nós usamos os StreamController, porém na view podemos usar
  // a Stream, para que ninguém de fora possa atualizar o valor do controller
  Stream<FormModel> get formStream => _streamController.stream;

  String? get name => model.name;
  String? get surname => model.surname;
  String get fullName => model.getFullName();

  set nome(String nome) => model.name = nome;

  void onChangeName(String name) {
    model.name = name;
  }

  void onChangeSurname(String surname) {
    model.surname = surname;
  }

  void saveUser() {
    internalStorage.saveUser(model.name ?? '', model.surname ?? '');

  }

  // Quando vc usa Stream é nessesário fechar a mesmo, pois caso o contrário ele vai
  // fica consumindo dados
  void dispose() {
    _streamController.close();
  }

  void deleteUser() {
    internalStorage.deleteUser(model.name ?? '', model.surname ?? '');
    initSetup();
//    model.deleteUser();
  }
}
