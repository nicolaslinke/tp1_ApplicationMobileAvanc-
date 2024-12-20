import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tp1_flutter/drawer.dart';
import 'package:tp1_flutter/lib_http.dart';
import 'package:tp1_flutter/task.dart';
import 'package:tp1_flutter/transfert.dart';


class Creation extends StatefulWidget {
  const Creation({super.key, required this.title});

  final String title;

  @override
  State<Creation> createState() => _CreationState();
}


class _CreationState extends State<Creation> {

  final _dateFormatter = DateFormat("yyyy-MM-dd");
  final TextEditingController UsernameTextController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String formattedDate = "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2,'0')}-${DateTime.now().day.toString().padLeft(2,'0')}";
  String imagePath = "";
  bool loading = false;

  void addTask() async
  {
    if (UsernameTextController.text.trim() != "") {
      var dateDifference = selectedDate.difference(DateTime.now());
      if (!dateDifference.isNegative) {
        CollectionReference<Task> tasksCollection = FirebaseFirestore.instance
            .collection('user')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('tasks')
            .withConverter<Task>(
          fromFirestore: (doc, _) => Task.fromJson(doc.data()!),
          toFirestore: (task, _) => task.toJson(),
        );
        QuerySnapshot<Task> result = await tasksCollection.get();
        var nameExist = false;
        for (var task in result.docs)
        {
           if (task.data().name == UsernameTextController.text.trim()) nameExist = true;
        }
        if (nameExist == false) {
          CollectionReference tasksCollection = FirebaseFirestore.instance
              .collection('user')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('tasks')
              .withConverter<Task>(
            fromFirestore: (doc, _) => Task.fromJson(doc.data()!),
            toFirestore: (task, _) => task.toJson(),
          );

          Task task = Task(name: UsernameTextController.text,
              creationDate: DateTime.now(),
              endDate: selectedDate,
              percCompletion: 0);
          tasksCollection.add(task);
          Navigator.pushNamed(context, '/accueil');
        }
        else
        {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Cette tâche existe déjà, veuillez choisir un nom différent")
          ));
        }
      }
      else
      {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("La date choisi doit être dans le future")
        ));
      }
    }
    else
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Le nom de la tâche ne peut pas être vide")
      ));
    }
    loading = false;
  }

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
      drawer : const LeTiroir(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Creation',
            ),
            TextFormField(
              controller: UsernameTextController,
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
              onPressed: () async {
                if (loading == false) {
                  try {
                    loading = true;
                    addTask();
                    AddTaskRequest req = AddTaskRequest();
                    req.name = UsernameTextController.text;
                    req.deadline = selectedDate; //selectedDate;
                    //var reponse = await addTask(req);
                    //print(reponse);
                  } on DioError catch (e) {
                    print(e);
                    loading = false;
                    String message = e.response!.data;
                    if (message == "BadCredentialsException") {
                      print('login deja utilise');
                    } else {
                      print('autre erreurs');
                    }
                  }
                }
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
