import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;

  bool validateAndSave(){
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;}
  }

  void validateAndSubmit() async{
    try {
      if (validateAndSave()){
     UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email!, password: _password!);  
    print('Usuário logado: ${user.user!.uid}');
    }
  } catch (e) { print('Erro: $e');}
    }
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Faça seu Login')
          ),
        body: Form(
          key: formKey,
          child: Column(
            children: [
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
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('Não tem conta? Cadastre-se aqui!'),
              ),
            ],
          ),
        ));
  }
}
