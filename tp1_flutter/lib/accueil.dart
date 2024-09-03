import 'package:flutter/material.dart';


class Accueil extends StatefulWidget {
  const Accueil({super.key, required this.title});

  final String title;

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
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
              'Accueil',
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.amber,

              ),
              onPressed: () {
                Navigator.pushNamed(context, '/creation');
              },
              child: Text(
                'Créé un tâche',
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.amber,

              ),
              onPressed: () {
                Navigator.pushNamed(context, '/consultation');
              },
              child: Text(
                'item',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
