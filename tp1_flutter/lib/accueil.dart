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
  bool hasError = false; // Ajout d'un état pour gérer les erreurs

  @override
  void initState() {
    super.initState();
    getTask();
  }

  Future<void> getTask() async {
    try {
        listTask = await getTasks();
        setState(() {
        hasError = false; // Réinitialiser l'erreur si la récupération réussie
      });
    } catch (error) {
      setState(() {
        hasError = true; // Mettre à jour l'état d'erreur
      });
      print(error); // Afficher l'erreur pour le débogage
    }
  }

  Future<void> delete(int id) async {
    try {
      await deleteTask(id);
      getTask();
    } catch (error) {
      print(error); // Afficher l'erreur pour le débogage
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      drawer: const LeTiroir(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Accueil'),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.amber,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/creation');
              },
              child: const Text('Créer une tâche'),
            ),
            if (hasError) ...[
              // Afficher un bouton de rafraîchissement si une erreur s'est produite
              Text('La page n\'a pas pu être chargé'),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.amber,
                ),
                onPressed: getTask, // Rafraîchir les tâches
                child: const Text('Rafraîchir'),
              ),
            ] else ...[
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
                            child: Text(listTask[index].percentageDone.toString() + "%"),
                          ),
                          Expanded(
                            child: Text(listTask[index].percentageTimeSpent.toString() + "%"),
                          ),
                          Expanded(
                            child: Text(listTask[index].deadline.toString()),
                          ),
                          Expanded(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.amber,
                              ),
                              onPressed: () => delete(listTask[index].id), // Rafraîchir les tâches
                              child: const Text('Supprimer'),
                            ),
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
          ],
        ),
      ),
    );
  }
}
