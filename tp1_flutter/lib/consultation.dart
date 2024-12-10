import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
  bool loading = true;
  var _imageFile;
  var _publicUrl;

  GetTasksResponse task = new GetTasksResponse();

  void sendImage() async {
    ImagePicker picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

    final supabase = Supabase.instance.client;

    String bucketid = 'supabucket';

    try {
      await supabase
          .storage
          .createBucket(bucketid, BucketOptions(public: true));
    } on StorageException catch (e) {
      if (e.error == "Duplicate") {
        // Le bucket existe déjà
        print(e);
      }
    }
    if (pickedImage != null) {
      //TODO doc: https://supabase.com/docs/reference/dart/storage-from-upload
      final String fullPath = await supabase
          .storage
          .from(bucketid)
          .upload(
        //TODO Mettre un nom unique
          pickedImage.name,
          File(pickedImage.path)
      );

      //TODO doc: https://supabase.com/docs/reference/dart/storage-from-getpublicurl
      _publicUrl = supabase
          .storage
          .from(bucketid)
          .getPublicUrl(pickedImage.name);
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
      CollectionReference<Task> tasksCollection = FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('tasks')
          .withConverter<Task>(
        fromFirestore: (doc, _) => Task.fromJson(doc.data()!),
        toFirestore: (task, _) => task.toJson(),
      );
      DocumentReference taskDoc = tasksCollection.doc(widget.id);
      taskDoc.delete();
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
      loading = false;
      setState(() {

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
            if (loading == false) ...[
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
            ],
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
              sendImage,
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
