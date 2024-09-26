import 'package:flutter/material.dart';
import 'package:front_end/pages/home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState()
  {
    super.initState();

    Future.delayed(Duration(seconds: 3)).then((_) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Colors.black,
      child: Column(
        children: [
          Image.asset('assets/images/logoEssentia.jpg'),
          CircularProgressIndicator(
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation(Color.fromRGBO(177, 155, 102, 1)),
            ),
          Container(height: 20),
          Text(
            'Carregando...',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          )
        ],
      ),
    ));
  }
}
