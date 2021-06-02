import 'package:flutter/material.dart';
import 'package:form_adaptativo/form_controller.dart';
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
  String names = '';

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    super.dispose();

  }
  void initState() {
    controller.initSetup();
    updateValue();

    super.initState();

  }

  void updateValue(){
      controller.stateStream.listen((data){
        nameController.text = data.name ?? 'testeNome';
        surnameController.text = data.surname ?? 'testeSobrenome';
        print(data.name);
        names = data.name ?? '';
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Container(
          constraints: BoxConstraints(
              maxHeight: 500, maxWidth: 450, minWidth: 300, minHeight: 300),
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
                   //   initialValue: controller.name ?? '',
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
                //      initialValue: controller.surname ?? '',
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
                    child: ElevatedButton(
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
                        child: Text('Validar')),
                  ),
                  FutureBuilder<String>(
                      future: controller.fullName,
                      builder: (context, snapshot) {
                        return Text(snapshot.data ?? ' ');
                      })
                  ,
                ],
              )),
        ),
      ),
    );
  }
}
