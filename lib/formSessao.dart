import 'package:flutter/material.dart';

class FormsSessao extends StatefulWidget {
  FormsSessao({super.key});

  @override
  _FormsSessaoState createState() => _FormsSessaoState();
}

class _FormsSessaoState extends State<FormsSessao> {
  final _formKey = GlobalKey<FormState>();
  final _controller = PageController();
  final _fields = [
    {'label': 'Frequência Cardíaca Inicial', 'validator': 'Por favor, insira a frequência cardíaca inicial'},
    {'label': 'SpO2', 'validator': 'Por favor, insira o SpO2'},
    {'label': 'PA', 'validator': 'Por favor, insira a PA'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Saúde'),
      ),
      body: Form(
        key: _formKey,
        child: PageView.builder(
          controller: _controller,
          itemCount: _fields.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: AlertDialog(
                content: TextFormField(
                  decoration: InputDecoration(labelText: _fields[index]['label']),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return _fields[index]['validator'];
                    }
                    return null;
                  },
                ),
                actions: [
                  if (index < _fields.length - 1)
                    ElevatedButton(
                      onPressed: () => _controller.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      ),
                      child: Text('Next'),
                    ),
                  if (index == _fields.length - 1)
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Processando Dados')),
                          );
                        }
                      },
                      child: Text('Enviar'),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
