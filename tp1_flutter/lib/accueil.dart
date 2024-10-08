import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tp1_flutter/consultation.dart';
import 'package:tp1_flutter/drawer.dart';
import 'package:tp1_flutter/lib_http.dart';
import 'package:tp1_flutter/transfert.dart';


class Accueil extends StatefulWidget {
  const Accueil({super.key, required this.title});

  final String title;

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  List<GetTasksResponse> listTask = [];

  @override
  void initState() {
    try {
      super.initState();
      getTask();
    } on DioError catch (e) {
      print(e);
      String message = e.response!.data;
      if (message == "BadCredentialsException") {
        print('login deja utilise');
      } else {
        print('autre erreurs');
      }
    }
  }

  Future<void> getTask() async {
    try {
      listTask = await getTasks();
      setState(() {
        // Update your state here if necessary
      });
    } catch (error) {
      // Handle the error appropriately
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      drawer : const LeTiroir(),
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
                itemCount: listTask.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(listTask[index].name),
                          ),
                          Expanded(
                            child: Text('    ' + listTask[index].percentageDone.toString()),
                          ),
                          Expanded(
                            child: Text('    ' + listTask[index].percentageTimeSpent.toString()),
                          ),
                          Expanded(
                            child: Text('       ' + listTask[index].deadline.toString()),
                          ),
                        ],
                      ),
                    onTap: () => Navigator.push(
                      context,
                        MaterialPageRoute(builder: (_) =>
                          Consultation(id: listTask[index].id))
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
