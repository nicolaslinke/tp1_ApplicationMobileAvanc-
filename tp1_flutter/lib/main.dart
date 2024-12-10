import 'package:firebase_auth/firebase_auth.dart'  as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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

import 'firebase_options.dart';

const supabaseUrl = 'https://emoryygsfeplxoxwdois.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVtb3J5eWdzZmVwbHhveHdkb2lzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM4NTE3NjAsImV4cCI6MjA0OTQyNzc2MH0.-CuITrECFo5hotsMR8Ut7pdEst8ONVIL7ZHLQxPiOl4';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
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

    //Firebase auth
    firebase_auth.FirebaseAuth.instance
        .authStateChanges()
        .listen((firebase_auth.User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in! ' + user.email!);
      }
    }
    );
    //

    SharedPreferences.getInstance().then((onValue) {
      _prefs = onValue;
      _obtenirPrefs();
    });
  }

  //Firebase auth
  Future<firebase_auth.UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = firebase_auth.GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    Navigator.pushNamed(context, '/accueil');
    // Once signed in, return the UserCredential
    return await firebase_auth.FirebaseAuth.instance.signInWithCredential(credential);
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
                  final credential = await firebase_auth.FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: UsernameTextController.text,
                      password: PasswordTextController.text
                  );
                  Singleton.instance.username = UsernameTextController.text;
                  Navigator.pushNamed(context, '/accueil');
                } on firebase_auth.FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');
                  }
                }
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

            //Firebase Auth
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.amber,

              ),
              onPressed: () {
                signInWithGoogle();
              },
              child: Text(
                'Sign in with google',
              ),
            ),
            MaterialButton(
              onPressed: () async {
                await GoogleSignIn().signOut();
                await firebase_auth.FirebaseAuth.instance.signOut();
                setState(() {});
              },
              child: Text("signout from google"),
            ),
          ],
        ),
      ),
    );
  }
}

