import 'package:flutter/material.dart';
import 'package:front_end/pages/articles_page.dart';
import 'package:front_end/pages/budget_page.dart';
import 'package:front_end/pages/contact_page.dart';
import 'package:front_end/pages/messages_page.dart';
import 'package:front_end/pages/reminders_page.dart';
import 'package:front_end/pages/profile_page.dart';

class AppMenuDrawer extends StatelessWidget {
  const AppMenuDrawer({super.key});
  
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/logoEssentiaPharma.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Text(''),
        ),
        _itemDrawer(context, Icon(Icons.article), 'Artigos', ArticlesPage()),
        _itemDrawer(context, Icon(Icons.access_time), 'Lembretes', RemindersPage()),
        _itemDrawer(context, Icon(Icons.attach_money), 'Orçamentos', BudgetPage()),
        _itemDrawer(context, Icon(Icons.chat), 'Mensagens', MessagesPage()),
        _itemDrawer(context, Icon(Icons.contact_mail), 'Contato', ContactPage()),
        _itemDrawer(context, Icon(Icons.person), 'Perfil', ProfilePage()),
      ],
    );
  }

  Widget _itemDrawer(context, Icon icon, String text, page) {
    return ListTile(
      leading: IconTheme(
        child: icon,
        data: IconThemeData(color: Colors.black),
      ),
      title: Text(
        text,
        style: TextStyle(color: Colors.black),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => page,
        ));
      },
    );
  }
}
