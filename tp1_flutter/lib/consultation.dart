import 'package:flutter/material.dart';


class Consultation extends StatefulWidget {
  const Consultation({super.key, required this.title});

  final String title;

  @override
  State<Consultation> createState() => _ConsultationState();
}

class _ConsultationState extends State<Consultation> {
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
              'Consultation',
            ),
            const Text(
              'Nom de la tâche'
            ),
            const Text(
                'Date'
            ),
            const Text(
                'Pourc 1'
            ),
            const Text(
                'Pourc 2'
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.amber,
              ),
              onPressed: () { },
              child: Text(
                'Modifier',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
