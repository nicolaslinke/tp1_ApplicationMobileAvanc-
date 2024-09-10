import 'package:flutter/material.dart';


class Creation extends StatefulWidget {
  const Creation({super.key, required this.title});

  final String title;

  @override
  State<Creation> createState() => _CreationState();
}


class _CreationState extends State<Creation> {
  DateTime selectedDate = DateTime.now();
  String formattedDate = "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2,'0')}-${DateTime.now().day.toString().padLeft(2,'0')}";

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        formattedDate = "${selectedDate.year.toString()}-${selectedDate.month.toString().padLeft(2,'0')}-${selectedDate.day.toString().padLeft(2,'0')}";
      });
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
              'Creation',
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nom de la tâche',
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.amber,
              ),
              onPressed: () { _selectDate(context); },
              child: Text(
                'Choisir une date',
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
