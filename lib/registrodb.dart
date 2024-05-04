import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistroDB extends StatefulWidget {
  const RegistroDB({super.key});

  @override
  State<RegistroDB> createState() => RegistroDBState();
  
}

class RegistroDBState extends State<RegistroDB> {
  final user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();

  final rtdb = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: 'https://fir-6a5e9-default-rtdb.firebaseio.com');

  FirebaseDatabase database = FirebaseDatabase.instance;
  String? nomepaciente;
  String? datanascimentopaciente;
  String fisio = 'fisioterapeutas/${FirebaseAuth.instance.currentUser?.displayName}';
  

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      print(nomepaciente);
      print(datanascimentopaciente);
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() {
    if (validateAndSave()) {
      database.ref().child(fisio).push().set({
        'pacientes': {'nomepaciente': nomepaciente, 'datanascimento': datanascimentopaciente}
      }
      ); 
    print(database);

    }
  }

  @override
  Widget build(BuildContext context) {
    final nome = user?.displayName ?? '';
    

    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo $nome'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Nome do Paciente',
              ),
              validator: (value) => value!.isEmpty ? 'inválido' : null,
              onSaved: (newValue) => nomepaciente = newValue,
            ),
             TextFormField(
              decoration: const InputDecoration(
                hintText: 'data de nascimento',
              ),
              validator: (value) => value!.isEmpty ? 'inválido' : null,
              onSaved: (newValue) => datanascimentopaciente = newValue,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: validateAndSubmit,
                child: const Text('Enviar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
