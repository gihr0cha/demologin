import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'registrodb.dart';

class FormsSessao extends StatefulWidget {
  final dynamic paciente;
  const FormsSessao({Key? key, required this.paciente}) : super(key: key);

  @override
  _FormsSessaoState createState() => _FormsSessaoState();
}
class _FormsSessaoState extends State<FormsSessao> {
final user = FirebaseAuth.instance.currentUser;
FirebaseDatabase database = FirebaseDatabase.instance;
  final _formKey = GlobalKey<FormState>();
  final _controller = PageController();
  

  

  final _fields = [
    {
      'label': 'Frequência Cardíaca',
      'validator': 'Por favor, insira a frequência cardíaca inicial'
    },
    {'label': 'SpO2', 'validator': 'Por favor, insira o SpO2 inicial'},
    {'label': 'PA', 'validator': 'Por favor, insira a PA inicial'},
    {'label': 'PSE', 'validator': 'Por favor, insira a PSE inicial'},
    {
      'label': 'Dor Torácica',
      'validator': 'Por favor, insira a dor torácica inicial'
    },
  ];

  
  String? _nomepaciente;
  Map<String, dynamic> healthParameters = {
  'freqCardiacaInicial': null,
  'spo2Inicial': null,
  'paInicial': null,
  'pseInicial': null,
  'dorToracicaInicial': null,
};




  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      print(healthParameters);
      return true;
    }
    else{
      print('não salvou');
      return false;
      }
  }

void validateAndSubmit() {
    if (validateAndSave()) {
      database.ref().child('pacientes').push().set({
        'fisio': user?.displayName,
        'nome': _nomepaciente,
        'dados': healthParameters
      }); 
      print(database);
    }
  }
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
                  decoration:
                      InputDecoration(labelText: _fields[index]['label']),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return _fields[index]['validator'];
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      switch (index) {
                        case 0:
                          healthParameters['freqCardiacaInicial'] = value;
                          break;
                        case 1:
                          healthParameters['spo2Inicial'] = value;
                          break;
                        case 2:
                          healthParameters['paInicial'] = value;
                          break;
                        case 3:
                          healthParameters['pseInicial'] = value;
                          break;
                        case 4:
                          healthParameters['dorToracicaInicial'] = value;
                          break;
                      }
                    });
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
                          validateAndSave();
                          
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
