import 'package:demologin/formSessao.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'registerfisio_page.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home_page.dart';
import 'registrodb.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try{
   await Firebase.initializeApp( 
      options: DefaultFirebaseOptions.currentPlatform);
    runApp(const MyApp()); 
  }catch(e){e;
    print('Error initializing Firebase: $e');}
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/': (context) => const RegistroDB(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterFisio(),
        '/home': (context) => const HomePage(),
        '/banco': (context) => const RegistroDB(),
        '/form': (context) => const FormsSessao()
      },   
    );
  }
}
