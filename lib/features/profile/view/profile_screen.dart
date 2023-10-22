import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Planning")
      ),
      drawer: Drawer(
        child: ListView(
          children: const <Widget>[
            ListTile(
              title: Text("Plans"),
            ),
            ListTile(
              title: Text("Analytics"),
            ),
            ListTile(
              title: Text("Settings"),
              leading: Icon(Icons.settings),
            ),
          ],
        )
      ),
    );
  }
}
