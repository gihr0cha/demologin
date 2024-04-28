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

  void validateAndSubmit() async {
    try {
      if (validateAndSave()) {
        UserCredential user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email!, password: _password!);
        Navigator.pushNamed(context, '/home');
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case "user-not-found":
            erroMessage = 'Nenhum usuário encontrado';
            break;
          case "wrong-password":
            erroMessage = 'Senha errada';
            break;
          default:
            erroMessage = 'Erro desconhecido';
        }
      } else {
        erroMessage = 'Erro desconhecido';
      }
      mensagem(context, erroMessage);
    }
  }
void mensagem(BuildContext context, String? erroMessage) {
    final snackBar = SnackBar(
      content: Text(erroMessage!),
      action: SnackBarAction(
        label: 'Fechar',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(title: const Text('Faça seu Login')),
          body: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Campo obrigatório' : null,
                  onSaved: (value) => _email = value,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Campo obrigatório' : null,
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
  