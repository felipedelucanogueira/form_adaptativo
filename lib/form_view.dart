import 'package:flutter/material.dart';
import 'package:form_adaptativo/form_controller.dart';

class FormView extends StatefulWidget {
  @override
  _FormViewState createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  final _formKey = GlobalKey<FormState>();
  final controller = FormController();

  void IsValid() {}

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
                      initialValue: controller.name,
                      decoration: InputDecoration(hintText: 'Nome'),
                      onChanged: (valor) {
                        setState(() {
                          controller.onChangeName(valor);
                          controller.saveUser();
                        });
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
                      initialValue: controller.surname,
                      decoration: InputDecoration(hintText: "Sobrenome"),
                      onChanged: (text) {
                        setState(() {
                          controller.onChangeSurname(text);
                          controller.saveUser();
                        });
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
                                final isValid =
                                    _formKey.currentState!.validate();
                                if (isValid) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(
                                              "Olá ${controller.name} ${controller.surname} "),
                                        );
                                      });
                                }
                                controller.saveUser();
                              },
                              child: Text('Validar')),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  controller.model.deleteUser();
                                });
                              }, child: Text('Deletar')),
                        ],
                      )),
                  FutureBuilder<String>(
                      future: controller.fullName,
                      builder: (context, snapshot) {
                        return Text(snapshot.data ?? ' ');
                      })
                ],
              )),
        ),
      ),
    );
  }
}
