import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tp1_flutter/drawer.dart';
import 'package:tp1_flutter/lib_http.dart';
import 'package:tp1_flutter/task.dart';
import 'package:tp1_flutter/transfert.dart';


class Consultation extends StatefulWidget {
  String id = "";
  Consultation({required this.id});

  @override
  State<Consultation> createState() => _ConsultationState();
}

class _ConsultationState extends State<Consultation> with WidgetsBindingObserver {
  final TextEditingController PourcentageTextController = TextEditingController();
  String imagePath = "";
  Task taskFirebase = new Task(name: "", creationDate: DateTime.now(), endDate: DateTime.now(), percCompletion: 0);
  var image;

  GetTasksResponse task = new GetTasksResponse();

  void getImage() async {
    ImagePicker picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
            pickedImage.path, filename: pickedImage.name),
        "taskID": task.id
      });

      Dio dio = await SingletonDio.getDio();

      var response =
      await dio.post('http://10.0.2.2:8787/file', data: formData);
      image = 'http://10.0.2.2:8787/file/' + response.toString();

      print(response);

      imagePath = pickedImage!.path;
      setState(() {});
    }
  }

  @override
  void initState() {
    try {
      WidgetsBinding.instance.addObserver(this);
      super.initState();
      getTaskRequest();
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

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed)
    {
      try {
        super.initState();
        getTaskRequest();
      } on DioError catch (e) {
        print(e);
        String message = e.response!.data;
        if (message == "BadCredentialsException") {
          print('login deja utilise');
        } else {
          print('autre erreurs');
        }
      }
      setState(() {});
    }
  }

  Future<void> delete(int id) async {
    try {
      await deleteTask(id);
      Navigator.pushNamed(context, '/accueil');
    } catch (error) {
      print(error); // Afficher l'erreur pour le débogage
    }
  }

  Future<void> getTaskRequest() async {
    try {
      CollectionReference<Task> tasksCollection = FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('tasks')
          .withConverter<Task>(
          fromFirestore: (doc, _) => Task.fromJson(doc.data()!),
          toFirestore: (task, _) => task.toJson(),
      );
      QuerySnapshot<Task> result = await tasksCollection.get();
      taskFirebase = result.docs.firstWhere((Task) => Task.id == widget.id).data();
      setState(() {

      });
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
        title: Text("Consultation"),
      ),
      drawer : const LeTiroir(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Consultation',
            ),
            Text(taskFirebase.name),
            Text(taskFirebase.endDate.toString()),
            Text("Pourcentage fait : " + taskFirebase.percCompletion.toString() + "%"),
            Text("Pourcentage de temps écoulé : " + (DateTime.now().difference(taskFirebase.creationDate).inMinutes
                / taskFirebase.endDate.difference(taskFirebase.creationDate).inMinutes * 100)
                .ceil().toString() + "%"),
            TextFormField(
              controller: PourcentageTextController,
              decoration: const InputDecoration(
                labelText: 'Modifier le pourcentage de complètion',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.amber,
              ),
              onPressed: () async {
                try {
                  CollectionReference<Task> tasksCollection = FirebaseFirestore.instance
                      .collection('user')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('tasks')
                      .withConverter<Task>(
                    fromFirestore: (doc, _) => Task.fromJson(doc.data()!),
                    toFirestore: (task, _) => task.toJson(),
                  );
                  DocumentReference taskDoc = tasksCollection.doc(widget.id);
                  
                  taskFirebase.percCompletion = int.parse(PourcentageTextController.text);

                  taskDoc.set(taskFirebase);

                  //DocumentReference taskDoc = tasksCollection.doc(widget.id);
                  Navigator.pushNamed(context, '/accueil');
                } on DioError catch (e) {
                  print(e);
                  String message = e.response!.data;
                  if (message == "BadCredentialsException") {
                    print('login deja utilise');
                  } else {
                    print('autre erreurs');
                  }
                }
              },
              child: Text(
                'Modifier',
              ),
            ),
            Expanded(
              child:
              (image==null)?Text("Selectionnez une image")
                  :Image.network(image),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.amber,
              ),
              onPressed:
              getImage,
              child: Text(
                'Selectionner une image',
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.amber,
              ),
              onPressed: () => delete(task.id), // Rafraîchir les tâches
              child: const Text('Supprimer'),
            ),
          ],
        ),
      ),
    );
  }
}
