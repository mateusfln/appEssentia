import 'package:flutter/material.dart';

class RemindersPage extends StatelessWidget {
  const RemindersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminders Page'),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromRGBO(21, 21, 21, 1),
      ),
      body: Center(
        child: Text('Reminders Page'),
      ),
    );
  }
}