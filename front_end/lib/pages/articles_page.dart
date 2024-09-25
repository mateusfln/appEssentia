import 'package:flutter/material.dart';

class ArticlesPage extends StatelessWidget {
  const ArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Articles Page'),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromRGBO(21, 21, 21, 1),
      ),
      body: Center(
        child: Text('Articles Page'),
      ),
    );
  }
}