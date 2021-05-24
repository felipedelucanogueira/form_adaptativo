import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String lastName = '';

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
                      decoration: InputDecoration(hintText: 'Nome'),
                      onChanged: (text) {
                        name = text;
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
                      decoration: InputDecoration(hintText: "Sobrenome"),
                      onChanged: (text) {
                        lastName = text;
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
                                    content:
                                        Text("Olá ${name + ' ' + lastName}"),
                                  );
                                });
                          }
                        },
                        child: Text('Validar')),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
