import 'package:flutter/material.dart';
import 'package:front_end/widgets/app_menu_drawer.dart';

class DefaultPage extends StatelessWidget {
  final String pageTitle;

  const DefaultPage({super.key, required this.pageTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: AppMenuDrawer(),
      ),
      appBar: AppBar(
        title: Text(pageTitle),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromRGBO(21, 21, 21, 1),
      ),
      body: Center(
        child: Text(pageTitle),
      ),
    );
  }
}
