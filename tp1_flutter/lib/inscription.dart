import 'package:dio/dio.dart';
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

  SignupRequest signupRequest = SignupRequest();

  void getHttp() async {
    try {
      var response = await Dio().post('http://10.0.2.2:8787/api/id/signup');
      print('RESPONSE : ' + response.toString());
      this.signupRequest = SignupRequest.fromJson(response.data);
      setState(() {

      });
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
              decoration: const InputDecoration(
                labelText: 'Nom d\'utilisateur',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Mot de passe',
              ),
              obscureText: true,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Confirmation de mot de passe',
              ),
              obscureText: true,
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.amber,

              ),
              onPressed: () async {
                try {
                  SignupRequest req = SignupRequest();
                  req.username = 'allo';
                  req.password = 'password';
                  var reponse = await signup(req);
                  print(reponse);
                  Navigator.pushNamed(context, '/');
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
                'S\'inscrire',
              ),
            ),
          ],
        ),
      ),
    );
  }
}


