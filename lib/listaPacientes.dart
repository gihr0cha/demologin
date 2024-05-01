import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:demologin/registrodb.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'formSessao.dart';
import 'package:firebase_database/firebase_database.dart';

class PacientePage extends StatefulWidget {
  const PacientePage({super.key, Key? paciente});

  @override
  State<PacientePage> createState() => _PacientePageState();
}

class _PacientePageState extends State<PacientePage> {
  @override
  Widget build(BuildContext context) {
  final user = FirebaseAuth.instance.currentUser;
  final database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: 'https://fir-6a5e9-default-rtdb.firebaseio.com');

    final fisio = 'fisioterapeutas/${user?.displayName ?? ''}';
    print(database.ref().child(fisio).onValue);
    print(fisio);

    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Column(
          children: [
            const Text(
              'FisioConecta - Home',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                  color: Colors.grey),
            ),
            Text(
              'Olá, $fisio!',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.grey),
            ),
          ],
        ),
        toolbarHeight: 72,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RegistroDB()));
        },
        backgroundColor: const Color(0xff4a9700),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: database.ref().child('pacientes').onValue,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data?.snapshot.value != null) {
            Map<dynamic, dynamic>map = snapshot.data.value;
            map = map.cast<String, dynamic>();

            return ListView.builder(
              itemCount: map.length,
              itemBuilder: (context, index) {
                try {
                  var outerData = map.values.toList()[index];
                  var innerData = outerData.values.toList()[0];
                  String nome = innerData['nome'] ?? 'Sem nome';
                  //String email = innerData['email'] ?? 'Sem email';
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FormsSessao()));
                    },
                    child: ListTile(
                      title: Text(nome),
                      //subtitle: Text(email),
                    ),
                  );
                } catch (e) {
                  print(e);
                  return const ListTile(
                    title: Text('Erro'),
                    subtitle: Text('Nenhum dado cadastrado'),
                  );
                }
              },
            );
          } else {
            print(e);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const RegistroDB()));
            });
            return Container(); 
          }
        },
      ),
    );
  }
}
