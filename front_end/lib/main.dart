import 'package:flutter/material.dart';
import 'package:front_end/splash.dart';

void main() => runApp(const MainApp());


class MainApp extends StatefulWidget {
  const MainApp({ Key? key }) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Essentia',
      home: Splash()
    );
  }
}