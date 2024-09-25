import 'package:flutter/material.dart';
import 'package:front_end/pages/reminders_add_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RemindersPage extends StatefulWidget {
  const RemindersPage({super.key});

  @override
  _RemindersPageState createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  List<String> reminders = [];
  String searchQuery = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchReminders();
  }

  Future<void> fetchReminders() async {
    final response = await http.get(Uri.parse('http://localhost:3333/api/v1/reminders'));

    if (response.statusCode == 200) {
      // Supondo que a resposta seja uma lista de lembretes em formato JSON
      List<dynamic> data = json.decode(response.body);
      setState(() {
        reminders = List<String>.from(data.map((reminder) => reminder['title'])); // Altere para a chave correta
        isLoading = false;
      });
    } else {
      throw Exception('Falha ao carregar lembretes');
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredReminders = reminders
        .where((reminder) => reminder.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('Lembretes'),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromRGBO(21, 21, 21, 1),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Pesquisar lembrete',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredReminders.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(filteredReminders[index]),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RemindersAddPage(
                                reminder: filteredReminders[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RemindersAddPage()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.grey[400],
      ),
    );
  }
}
