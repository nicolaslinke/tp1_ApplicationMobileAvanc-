import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tp1_flutter/lib_http.dart';
import 'package:tp1_flutter/transfert.dart';


class Inscription extends StatefulWidget {
  const Inscription({super.key, required this.title});

  final String title;

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {

  final TextEditingController UsernameTextController = TextEditingController();
  final TextEditingController PasswordTextController = TextEditingController();
  final TextEditingController PasswordConfirmTextController = TextEditingController();
  SignupRequest signupRequest = SignupRequest();
  bool loading = false;

  Future<void> inscription() async
  {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: UsernameTextController.text,
        password: PasswordTextController.text,
      );
      Navigator.pushNamed(context, '/accueil');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
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
              'Inscription',
            ),
            TextFormField(
              controller: UsernameTextController,
              decoration: const InputDecoration(
                labelText: 'Nom d\'utilisateur',
              ),
            ),
            TextFormField(
              controller: PasswordTextController,
              decoration: const InputDecoration(
                labelText: 'Mot de passe',
              ),
              obscureText: true,
            ),
            TextFormField(
              controller: PasswordConfirmTextController,
              decoration: const InputDecoration(
                labelText: 'Confirmation de mot de passe',
              ),
              obscureText: true,
            ),
            (loading==true)?new Center(
              child: new SizedBox(
                height: 50.0,
                width: 50.0,
                child: new CircularProgressIndicator(
                  value: null,
                  strokeWidth: 7.0,
                ),
              ),
            ):
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.amber,

              ),
              onPressed: () async {
                if (loading == false) {
                  try {
                    loading = true;
                    setState(() {

                    });
                    //SignupRequest req = SignupRequest();
                    //req.username = UsernameTextController.text;
                    //req.password = PasswordTextController.text;
                    //var reponse = await signup(req);
                    //print(reponse);
                    inscription();
                  } on DioException catch (e) {
                    loading = false;
                    setState(() {

                    });
                    var response = e.response.toString();
                    if (response == null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Pas de réseau")
                      ));
                    } else if (response == "UsernameTooShort") {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Le nom d\'utilisateur est trop court")
                      ));
                    } else if (response == "PasswordTooShort") {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Le mot de passe est trop court")
                      ));
                    }
                    print("LOGCAT : " + e.response.toString());
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
                'S\'inscrire',
              ),
            ),
          ],
        ),
      ),
    );
  }
}


