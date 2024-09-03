import 'package:flutter/material.dart';
import 'package:tp1_flutter/inscription.dart';
import 'package:tp1_flutter/accueil.dart';
import 'package:tp1_flutter/consultation.dart';
import 'package:tp1_flutter/creation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      routes: {
        '/': (context) => MyHomePage(title: "Test"),
        '/inscription': (context) => Inscription(title: "Inscription",),
        '/accueil': (context) => Accueil(title: "Accueil",),
        '/consultation': (context) => Consultation(title: "Consultation",),
        '/creation': (context) => Creation(title: "Creation",),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Connexion',
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nom d\'utilisateur',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Mot de passe',
              ),
              obscureText: true,
            ),
            TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.amber,

                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/accueil');
                },
                child: Text(
                    'Connexion',
                ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.amber,

              ),
              onPressed: () {
                Navigator.pushNamed(context, '/inscription');
              },
              child: Text(
                'Inscription',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

