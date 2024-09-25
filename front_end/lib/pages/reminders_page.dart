// // import 'package:flutter/material.dart';
// // import 'package:front_end/pages/reminders_add_page.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';

// // class RemindersPage extends StatefulWidget {
// //   const RemindersPage({super.key});

// //   @override
// //   _RemindersPageState createState() => _RemindersPageState();
// // }

// // class _RemindersPageState extends State<RemindersPage> {
// //   List<String> reminders = [];
// //   String searchQuery = '';
// //   bool isLoading = true;

// //   @override
// //   void initState() {
// //     super.initState();
// //     fetchReminders();
// //   }

// //   Future<void> fetchReminders() async {
// //     final response = await http.get(Uri.parse('http://localhost:3333/api/v1/reminders'));

// //     if (response.statusCode == 200) {
// //       // Supondo que a resposta seja uma lista de lembretes em formato JSON
// //       List<dynamic> data = json.decode(response.body);
// //       setState(() {
// //         reminders = List<String>.from(data.map((reminder) => reminder['title'])); // Altere para a chave correta
// //         isLoading = false;
// //       });
// //     } else {
// //       throw Exception('Falha ao carregar lembretes');
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final filteredReminders = reminders
// //         .where((reminder) => reminder.toLowerCase().contains(searchQuery.toLowerCase()))
// //         .toList();

// //     return Scaffold(
// //       appBar: AppBar(
// //         foregroundColor: Colors.white,
// //         title: Text('Lembretes'),
// //         iconTheme: IconThemeData(color: Colors.white),
// //         backgroundColor: Color.fromRGBO(21, 21, 21, 1),
// //       ),
// //       body: isLoading
// //           ? Center(child: CircularProgressIndicator())
// //           : Column(
// //               children: [
// //                 Padding(
// //                   padding: const EdgeInsets.all(16.0),
// //                   child: TextField(
// //                     onChanged: (value) {
// //                       setState(() {
// //                         searchQuery = value;
// //                       });
// //                     },
// //                     decoration: InputDecoration(
// //                       labelText: 'Pesquisar lembrete',
// //                       border: OutlineInputBorder(),
// //                       prefixIcon: Icon(Icons.search),
// //                     ),
// //                   ),
// //                 ),
// //                 Expanded(
// //                   child: ListView.builder(
// //                     itemCount: filteredReminders.length,
// //                     itemBuilder: (context, index) {
// //                       return ListTile(
// //                         title: Text(filteredReminders[index]),
// //                         onTap: () {
// //                           Navigator.push(
// //                             context,
// //                             MaterialPageRoute(
// //                               builder: (context) => RemindersAddPage(
// //                                 reminder: filteredReminders[index],
// //                               ),
// //                             ),
// //                           );
// //                         },
// //                       );
// //                     },
// //                   ),
// //                 ),
// //               ],
// //             ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {
// //           Navigator.push(
// //             context,
// //             MaterialPageRoute(builder: (context) => RemindersAddPage()),
// //           );
// //         },
// //         child: Icon(Icons.add),
// //         backgroundColor: Colors.grey[400],
// //       ),
// //     );
// //   }
// // }


// import 'package:flutter/material.dart';
// import 'package:front_end/pages/reminders_add_page.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:intl/intl.dart';


// class RemindersPage extends StatefulWidget {
//   const RemindersPage({super.key});

//   @override
//   _RemindersPageState createState() => _RemindersPageState();
// }

// class _RemindersPageState extends State<RemindersPage> {
//   List reminders = []; // Alterado para um mapa
//   String searchQuery = '';
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchReminders();
//   }

//   Future<void> fetchReminders() async {
//     final response = await http.get(Uri.parse('http://localhost:3333/api/v1/reminders'));

//     if (response.statusCode == 200) {
//       List<dynamic> data = json.decode(response.body);
//       setState(() {
//         reminders = List<Map<String, dynamic>>.from(data);
//         isLoading = false;
//       });
//     } else {
//       throw Exception('Falha ao carregar lembretes');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final filteredReminders = reminders
//         .where((reminder) => reminder['title'].toLowerCase().contains(searchQuery.toLowerCase()))
//         .toList();

//     return Scaffold(
//       appBar: AppBar(
//         foregroundColor: Colors.white,
//         title: Text('Lembretes'),
//         iconTheme: IconThemeData(color: Colors.white),
//         backgroundColor: Color.fromRGBO(21, 21, 21, 1),
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: TextField(
//                     onChanged: (value) {
//                       setState(() {
//                         searchQuery = value;
//                       });
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'Pesquisar lembrete',
//                       border: OutlineInputBorder(),
//                       prefixIcon: Icon(Icons.search),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: filteredReminders.length,
//                     itemBuilder: (context, index) {
//                       final reminder = filteredReminders[index];
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//                         child: Card(
//                           elevation: 4,
//                           child: ListTile(
//                             title: Text(
//                               reminder['title'],
//                               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                             ),
//                             subtitle: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   reminder['description'], // Exibe a descrição
//                                   style: TextStyle(fontSize: 12, color: Colors.grey),
//                                 ),
//                                 SizedBox(height: 4),
//                                 Row(
//                                   children: [
//                                     Icon(Icons.access_time, size: 16, color: Colors.grey),
//                                     SizedBox(width: 4),
//                                     Text(
//                                       DateFormat.Hm().format(DateTime.parse(reminder['timetable'])), // Hora do lembrete
//                                       style: TextStyle(fontSize: 14),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => RemindersAddPage(
//                                     reminder: reminder['title'].toString(),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => RemindersAddPage()),
//           );
//         },
//         child: Icon(Icons.add),
//         backgroundColor: Colors.grey[400],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:front_end/pages/reminders_add_page.dart';
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
    final response = await http.delete(Uri.parse('http://localhost:3333/api/v1/reminders/$id'));

    if (response.statusCode == 200) {
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RemindersPage()),
    ); // Recarregar lembretes após exclusão
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha ao excluir lembrete')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredReminders = reminders
        .where((reminder) => reminder['title'].toLowerCase().contains(searchQuery.toLowerCase()))
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
                      final reminder = filteredReminders[index];
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
                              Text("EXCLUIR", style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                        confirmDismiss: (direction) async {
                          return await _showDeleteConfirmationDialog(context);
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          child: Card(
                            elevation: 4,
                            child: ListTile(
                              title: Text(
                                reminder['title'],
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    reminder['description'],
                                    style: TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.access_time, size: 16, color: Colors.grey),
                                      SizedBox(width: 4),
                                      Text(
                                        DateFormat.Hm().format(DateTime.parse(reminder['timetable'])),
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
                                    builder: (context) => RemindersAddPage(
                                      reminder: reminder['title'].toString(),
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
        child: Icon(Icons.add),
        backgroundColor: Colors.grey[400],
      ),
    );
  }

  Future<bool?> _showDeleteConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmação de Exclusão'),
          content: Text('Tem certeza de que deseja excluir este lembrete?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Excluir'),
            ),
          ],
        );
      },
    );
  }
}
