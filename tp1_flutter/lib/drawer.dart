import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tp1_flutter/Singleton.dart';
import 'package:tp1_flutter/accueil.dart';

class LeTiroir extends StatefulWidget {
  const LeTiroir({super.key});

  @override
  State<LeTiroir> createState() => LeTiroirState();
}

class LeTiroirState extends State<LeTiroir> {
  @override
  Widget build(BuildContext context) {
    var listView = ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          height: 200,
        ),
        Text(
            Singleton.instance.username
        ),
        ListTile(
          dense: true,
          leading: const Icon(Icons.ac_unit),
          title: const Text("Accueil"),
          onTap: () {
            // TODO ferme le tiroir de navigation
            Navigator.pushNamed(context, '/accueil');
            // Then close the drawer
          },
        ),

        // TODO le tiroir de navigation ne peut pointer que vers des
        // ecran sans paramtre.
        ListTile(
          dense: true,
          leading: const Icon(Icons.ac_unit),
          title: const Text("Ajout de tâche"),
          onTap: () {
            Navigator.pushNamed(context, '/creation');
            // Then close the drawer
          },
        ),
        ListTile(
          dense: true,
          leading: const Icon(Icons.ac_unit),
          title: const Text("Déconnexion"),
          onTap: () {
            Singleton.instance.username = "";
            SharedPreferences.getInstance().then((onValue) {
              onValue.remove("username");
              onValue.remove("password");
            });
            Navigator.pushNamed(context, '/');
            // Then close the drawer
          },
        ),
      ],
    );

    return Drawer(
      child: Container(
        color: const Color(0xFFFFFFFF),
        child: listView,
      ),
    );
  }
}