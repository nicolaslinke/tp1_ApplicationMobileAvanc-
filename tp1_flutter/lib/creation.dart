import 'package:flutter/material.dart';


class Creation extends StatefulWidget {
  const Creation({super.key, required this.title});

  final String title;

  @override
  State<Creation> createState() => _CreationState();
}

class _CreationState extends State<Creation> {
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
              'Creation',
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nom de la tâche',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Date',
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.amber,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/accueil');
              },
              child: Text(
                'Créé la tâche',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
