import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Page'),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromRGBO(21, 21, 21, 1),
      ),
      body: Center(
        child: Text('Contact Page'),
      ),
    );
  }
}