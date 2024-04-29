import 'package:demologin/formSessao.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final nome = user?.displayName ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo, $nome'),
      ),
      body: Center(
         child: ElevatedButton(
          onPressed: () => entrar(context),
          child: Text('Enter'),
          ),
      ),
    );
  }

  void entrar(BuildContext context) {
    // Navigate to FormsSessao
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormsSessao()),
    );
  }
}
