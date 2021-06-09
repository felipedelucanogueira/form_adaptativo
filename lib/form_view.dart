import 'dart:async';

import 'package:form_adaptativo/form_controller.dart';
import 'package:flutter/material.dart';
import 'package:form_adaptativo/form_model.dart';

class FormView extends StatefulWidget {
  @override
  _FormViewState createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  final _formKey = GlobalKey<FormState>();

  final controller = FormController();

  final nameController = TextEditingController();
  final surnameController = TextEditingController();

  // Aq eu uso StreamSubscription para poder fechar o listne
  late StreamSubscription<FormModel> _streamSubscription;

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    controller.dispose();
    // Fechando a StreamSubscription
    _streamSubscription.cancel();
    super.dispose();
  }

  void initState() {
    controller.initSetup();
    _updateValues();

    super.initState();
  }

  void _updateValues() {
    // Usando o listen, toda vez que o valor mudar a tream chama esse método
    // antes nós estavamos pegando os dados porém a view não se atualiza
    _streamSubscription = controller.formStream.listen((model) {
      nameController.text = model.name ?? '';
      surnameController.text = model.surname ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: 500,
            maxWidth: 450,
            minWidth: 300,
            minHeight: 300,
          ),
          padding: EdgeInsets.only(left: 20, right: 20),
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(hintText: 'Nome'),
                    onChanged: (valor) {
                      controller.nome = valor;
                    },
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Esse campo é obrigatório';
                      }
                      return null;
                    },
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    controller: surnameController,
                    decoration: InputDecoration(hintText: "Sobrenome"),
                    onChanged: (text) {
                      controller.onChangeSurname(text);
                    },
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Esse campo é obrigatório';
                      }
                      return null;
                    },
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          final isValid = _formKey.currentState!.validate();
                          if (isValid) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text(
                                        "Olá ${controller.name} ${controller.surname} "),
                                  );
                                });
                            controller.saveUser();
                          }
                        },
                        child: Text('Validar'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.deleteUser();

                        },
                        child: Text('Deletar'),
                      ),
                    ],

                  )
                ),
                StreamBuilder<FormModel>(
                  stream: controller.formStream,
                  builder: (context, snapshot) {
                    return Text(snapshot.data?.getFullName() ?? '');
                  },
                ),
                // FutureBuilder<String>(
                //     future:controller.internalStorage.getFullName()
                //     ,builder: (context ,snapshot){
                //   return Text(snapshot.data ?? '');
                //
                // })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
