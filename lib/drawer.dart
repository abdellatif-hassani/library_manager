import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey[200], // Change background color here
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 117, 33, 243),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset('assets/logo.png', height: 80.0),
                  SizedBox(height: 8.0),
                  Text(
                    'Abdellatif Hassani',
                    style: TextStyle(
                      color: Color.fromARGB(255, 5, 4, 5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Bibliothèque',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Accueil'),
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            Divider(), // Add separator
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Livres'),
              onTap: () {
                Navigator.pushNamed(context, '/books');
              },
            ),
            Divider(), // Add separator
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Adhérents'),
              onTap: () {
                Navigator.pushNamed(context, '/members');
              },
            ),
            Divider(), // Add separator
            ListTile(
              leading: Icon(Icons.info),
              title: Text('À propos'),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
            Divider(), // Add separator
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                // Handle the logout functionality here
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
