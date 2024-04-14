import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistroDB extends StatefulWidget {
  const RegistroDB({super.key});

  @override
  State<RegistroDB> createState() => _RegistroDBState();
}

class _RegistroDBState extends State<RegistroDB>
    with SingleTickerProviderStateMixin {
  final user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();

  FirebaseDatabase database = FirebaseDatabase.instance;
  String? _nomepaciente;
  late AnimationController _controller;

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      print(_nomepaciente);
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() {
    if (validateAndSave()) {
      database.ref().child('pacientes').push().set({
        'nome': _nomepaciente,
        'fisio': user?.uid,
      });
      print(database);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              onSaved: (newValue) => _nomepaciente = newValue,
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
