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
    FirebaseDatabase database = FirebaseDatabase.instance;

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
            stream: database.ref().child('cadastrados').onValue,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData && snapshot.data?.snapshot.value != null) {
                Map<dynamic, dynamic> map = snapshot.data!.snapshot.value;
                Map<String, dynamic> formattedMap = {};
                map.forEach((key, value) {
                  formattedMap[key.toString()] = value;
                });

                return ListView.builder(
                  itemCount: formattedMap.length,
                  itemBuilder: (context, index) {
                    try {
                      var outerData = formattedMap.values.toList()[index];
                      var patientData = outerData['paciente'];
                      String nome = patientData.keys.first;
                      String email = patientData.values.first;
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FormsSessao(paciente: patientData)));
                        },
                        child: ListTile(
                          title: Text(nome),
                          subtitle: Text(email),
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
                return CircularProgressIndicator();
              }
            }));
  }
}
