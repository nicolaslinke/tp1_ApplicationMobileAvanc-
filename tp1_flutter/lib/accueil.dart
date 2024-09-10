import 'dart:math';

import 'package:flutter/material.dart';


class Accueil extends StatefulWidget {
  const Accueil({super.key, required this.title});

  final String title;

  @override
  State<Accueil> createState() => _AccueilState();
}

class ListeElement {
  late String nom;
  late int pourcCompl;
  late int pourcEcoule;
  late DateTime dateLim;
}

class _AccueilState extends State<Accueil> {
  List<ListeElement> listeEnMemoire = [];

  @override
  void initState() {
    super.initState();
    listeEnMemoire = [];
    for (var i = 0; i < 100; i++) {
      ListeElement element = ListeElement();
      element.pourcCompl = (i + 5) * 10 + 3;
      element.pourcEcoule = (i + 5) * 10 + 3;
      element.nom =
      "element #${i.toRadixString(16)}"; // donne la repr d'un nombre en base 16 genre hexa quoi
      listeEnMemoire.add(element);
    }
  }

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
            Expanded(
              child: ListView.builder(
                itemCount: listeEnMemoire.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Text(listeEnMemoire[index].nom + '  ' + listeEnMemoire[index].pourcCompl.toString()),
                    onTap: () {
                      Navigator.pushNamed(context, '/consultation');
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
