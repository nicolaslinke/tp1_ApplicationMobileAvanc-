import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tp1_flutter/drawer.dart';
import 'package:tp1_flutter/lib_http.dart';
import 'package:tp1_flutter/transfert.dart';


class Consultation extends StatefulWidget {
  int id = -1;
  Consultation({required this.id});

  @override
  State<Consultation> createState() => _ConsultationState();
}

class _ConsultationState extends State<Consultation> {
  final TextEditingController PourcentageTextController = TextEditingController();

  GetTasksResponse task = new GetTasksResponse();

  @override
  void initState() {
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
  }

  Future<void> getTaskRequest() async {
    try {
      task = await getTask(widget.id);
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
            Text(task.name),
            Text(task.deadline.toString()),
            Text("Pourcentage fait : " + task.percentageDone.toString() + "%"),
            Text("Pourcentage de temps écoulé : " + task.percentageTimeSpent.toString() + "%"),
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
                  var reponse = await changeTask(task.id, int.parse(PourcentageTextController.text));
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
                'Modifier',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
