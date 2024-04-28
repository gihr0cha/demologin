import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'sessao_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
          child: Text('Iniciar sessão'),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return MyDialog();
              },
            );
          },
        ),
      ),
    );
  }
}