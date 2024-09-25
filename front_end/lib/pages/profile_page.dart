import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromRGBO(21, 21, 21, 1),
      ),
      body: Center(
        child: Text('Profile Page'),
      ),
    );
  }
}