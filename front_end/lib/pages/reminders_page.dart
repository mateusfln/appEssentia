import 'package:flutter/material.dart';
import 'package:front_end/pages/reminders_add_page.dart';
import 'package:front_end/widgets/app_menu_drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class RemindersPage extends StatefulWidget {
  const RemindersPage({super.key});

  @override
  _RemindersPageState createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  List reminders = [];
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
      List<dynamic> data = json.decode(response.body);
      setState(() {
        reminders = List<Map<String, dynamic>>.from(data);
        isLoading = false;
      });
    } else {
      throw Exception('Falha ao carregar lembretes');
    }
  }

  Future<void> _deleteReminder(String id) async {
    final response = await http
        .delete(Uri.parse('http://localhost:3333/api/v1/reminders/$id'));
    print(response.statusCode);
    if (response.statusCode ==  204) {
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RemindersPage()),
    );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha ao excluir lembrete')),
      );
    }
  }

  Future<bool?> _showDeleteConfirmationDialog(
      BuildContext context, String name, id) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmação de Exclusão'),
          content: Text(
              'Tem certeza de que deseja excluir o lembrete com o nome "$name"'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
              Navigator.of(context).pop(true); 
              },
              child: Text('Excluir'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredReminders = reminders
        .where((reminder) => reminder['title'].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      drawer: Drawer(
          child: AppMenuDrawer(),
        ),
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
                  child: filteredReminders.isEmpty
                      ? Center(
                          child: Card(
                            color: Colors.amber[300],
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Nenhum lembrete registrado.',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredReminders.length,
                          itemBuilder: (context, index) {
                            final reminder = filteredReminders[index];
                            var name = reminder['title'].toString();
                            var id = reminder['id'].toString();
                            return Dismissible(
                              key: Key(reminder['id'].toString()),
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  children: [
                                    Icon(Icons.delete, color: Colors.white),
                                    SizedBox(width: 10),
                                    Text("EXCLUIR",
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ),
                              confirmDismiss: (direction) async {
                                return await _showDeleteConfirmationDialog(
                                    context, name, id);
                              },
                              onDismissed: (direction) {
                                _deleteReminder(reminder['id'].toString());
                                setState(() {
                                  reminders.removeAt(index);
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Lembrete excluído')),
                                );
                              },
                              direction: DismissDirection.startToEnd,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                child: Card(
                                  elevation: 4,
                                  child: ListTile(
                                    title: Text(
                                      reminder['title'],
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          reminder['description'],
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(Icons.access_time,
                                                size: 16, color: Colors.black),
                                            SizedBox(width: 4),
                                            Text(
                                              DateFormat.Hm().format(
                                                  DateTime.parse(
                                                      reminder['timetable'])),
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RemindersAddPage(
                                            reminderId: reminder['id'].toString(),
                                            reminder: reminder['title'].toString(),
                                            details: reminder['description'],
                                            observations: reminder['observations'],
                                            time: TimeOfDay.fromDateTime(DateTime.parse(reminder['timetable'])),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
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
        shape: CircleBorder(),
        backgroundColor: Colors.grey[200],
        child: Icon(Icons.add),
      ),
    );
  }
}
