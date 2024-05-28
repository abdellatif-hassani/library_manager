import 'package:flutter/material.dart';
import 'drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
          Image.asset('assets/library.png'),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Bienvenue à la Bibliothèque publique de notre ville. Explorez notre collection de livres et adhérez pour plus d\'avantages.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
