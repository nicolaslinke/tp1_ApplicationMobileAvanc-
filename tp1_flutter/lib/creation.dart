import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tp1_flutter/drawer.dart';
import 'package:tp1_flutter/lib_http.dart';
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

  void getImage() async {
    ImagePicker picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    imagePath = pickedImage!.path;
    setState(() {

    });
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
                try {
                  AddTaskRequest req = AddTaskRequest();
                  req.name = UsernameTextController.text;
                  req.deadline = selectedDate; //selectedDate;
                  var reponse = await addTask(req);
                  print(reponse);

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
                'Créé la tâche',
              ),
            ),
            (imagePath=="")?Text("Selectionnez une image")
                :Image.file(File(imagePath )),
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
          ],
        ),
      ),
    );
  }
}
