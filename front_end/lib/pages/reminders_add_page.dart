import 'dart:convert';
import 'package:front_end/pages/reminders_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class RemindersAddPage extends StatefulWidget {
  final String? reminder;

  const RemindersAddPage({super.key, this.reminder});

  @override
  _RemindersAddPageState createState() => _RemindersAddPageState();
}

class _RemindersAddPageState extends State<RemindersAddPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _observationsController = TextEditingController();
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    if (widget.reminder != null) {
      _titleController.text = widget.reminder!; // Preenche o título se for edição
    }
  }

  Future<void> _sendReminder() async {
    String title = _titleController.text;
    String details = _detailsController.text;
    String observations = _observationsController.text;
    TimeOfDay selectedTime = TimeOfDay.fromDateTime(DateTime.now());
    DateTime now = DateTime.now();
    // DateTime alarmDateTime = DateTime(
    //   now.year,
    //   now.month,
    //   now.day,
    //   selectedTime.hour,
    //   selectedTime.minute,
    // );

    DateTime alarmDateTime = _selectedTime != null
      ? DateTime(now.year, now.month, now.day, _selectedTime!.hour, _selectedTime!.minute)
      : DateTime(now.year, now.month, now.day, now.hour, now.minute);


    // Formata o DateTime para o formato desejado
    String alarmTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(alarmDateTime);

    final Map<String, dynamic> data = {
      'title': title,
      'description': details,
      'observations': observations,
      'timetable': alarmTime,
    };
    final response = await http.post(
      Uri.parse('http://localhost:3333/api/v1/reminders'), // Substitua pela sua URL
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      // Lembrete criado com sucesso
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RemindersPage()),
    );
    } else {
      // Trate o erro conforme necessário
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha ao criar lembrete')),
      );
    }
  }

   Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.reminder == null ? 'Adicionar Lembrete' : 'Editar Lembrete'),
        backgroundColor: Color.fromRGBO(21, 21, 21, 1),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _detailsController,
              decoration: InputDecoration(
                labelText: 'Detalhes',
                border: OutlineInputBorder(),
              ),
              maxLines: 3, // Permite múltiplas linhas
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () => _selectTime(context),
              child: AbsorbPointer(
                child: TextField(
                  decoration: InputDecoration(
                    //labelText: 'Horário do Alarme',
                    border: OutlineInputBorder(),
                    hintText: _selectedTime != null ? _selectedTime!.format(context) : 'Selecione um horário',
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _observationsController,
              decoration: InputDecoration(
                labelText: 'Observações',
                border: OutlineInputBorder(),
              ),
              maxLines: 3, // Permite múltiplas linhas
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendReminder,
              child: Text('Salvar Lembrete'),
            ),
          ],
        ),
      ),
    );
  }
}
