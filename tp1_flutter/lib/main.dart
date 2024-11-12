import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tp1_flutter/Singleton.dart';
import 'package:tp1_flutter/inscription.dart';
import 'package:tp1_flutter/accueil.dart';
import 'package:tp1_flutter/consultation.dart';
import 'package:tp1_flutter/creation.dart';
import 'package:dio/dio.dart';
import 'package:tp1_flutter/lib_http.dart';
import 'package:tp1_flutter/transfert.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('fr'), // French
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      routes: {
        '/': (context) => MyHomePage(title: "Test"),
        '/inscription': (context) => Inscription(title: "Inscription",),
        '/accueil': (context) => Accueil(title: "Accueil",),
        '/creation': (context) => Creation(title: "Creation",),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final TextEditingController UsernameTextController = TextEditingController();
  final TextEditingController PasswordTextController = TextEditingController();
  late SharedPreferences _prefs;
  String username = "";
  String password = "";

  SignupRequest signupRequest = SignupRequest();

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((onValue) {
      _prefs = onValue;
      _obtenirPrefs();
    });
  }

  _definirPrefs()  {
    _prefs.setString('username', UsernameTextController.text);
    _prefs.setString('password', PasswordTextController.text);
  }

  _obtenirPrefs() async {
    username = _prefs.getString('username') ?? '';
    password = _prefs.getString('password') ?? '';
    if (username != '')
    {
      try {
        SigninRequest req = SigninRequest();
        req.username = username;
        req.password = password;
        var reponse = await signin(req);
        print(reponse);
        Singleton.instance.username = reponse.username;
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
  }


  void getHttp() async {
    try {
      var response = await Dio().get('http://10.0.2.2:8787/api/id/signup');
      print('RESPONSE : ' + response.toString());
      this.signupRequest = response.data;
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
              'Connexion',
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
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.amber,

              ),
              onPressed: () async {
                try {
                  SigninRequest req = SigninRequest();
                  req.username = UsernameTextController.text;
                  req.password = PasswordTextController.text;
                  var reponse = await signin(req);
                  print(reponse);
                  Singleton.instance.username = reponse.username;
                  _definirPrefs();
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
                'Connexion',
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.amber,

              ),
              onPressed: () {
                Navigator.pushNamed(context, '/inscription');
              },
              child: Text(
                'Inscription',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

