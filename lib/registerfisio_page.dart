import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class RegisterFisio extends StatefulWidget {
  const RegisterFisio({super.key});

  @override
  State<RegisterFisio> createState() => _RegisterFisioState();
}

class _RegisterFisioState extends State<RegisterFisio> {
  final formKey = GlobalKey<FormState>();
  String? _nome;
  String? _email;
  String? _password;
  String? erroMessage;
  

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
  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _email!,
      password: _password!,
  );
  await userCredential.user!.updateDisplayName(_nome);
  Navigator.pushNamed(context, '/home');
} on FirebaseAuthException catch (e) { 
  if (e.code == 'weak-password') {
    erroMessage = 'A senha fornecida é muito fraca';
  } else if (e.code == 'email-already-in-use') {
    erroMessage = 'Esse e-mail já está em uso';
  } else{
    erroMessage = 'Erro desconhecido';
  }
  mensagem(context,erroMessage);
  
} catch (e) {
  erroMessage = 'Erro desconhecido';
}
    }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Faça seu Cadastro')),
        body: Form(
          key: formKey,
          child: Column(children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              onSaved: (value) => _nome = value,
            ),
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

  void mensagem(BuildContext context, String? erroMessage){
    final snackBar = SnackBar(
      content: Text(erroMessage!),
      action: SnackBarAction(
        label: 'Fechar',
        onPressed: (){
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  } 
}