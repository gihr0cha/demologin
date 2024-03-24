import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class RegisterFisio extends StatefulWidget {
  const RegisterFisio({super.key});

  @override
  State<RegisterFisio> createState() => _RegisterFisioState();
}

class _RegisterFisioState extends State<RegisterFisio> {
  final formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

void validateAndSubmit() async{
  if (validateAndSave()){
  try {
  await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: _email!,
    password: _password!,
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
} catch (e) {
  print(e);
}
    }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Faça seu Login')),
        body: Form(
          key: formKey,
          child: Column(children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'E-mail',
              ),
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              onSaved: (value) => _email = value,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Senha',
              ),
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              onSaved: (value) => _password = value,
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: validateAndSubmit,
              child: const Text('Entrar'),
            ),
          ]),
        ));
  }
}
