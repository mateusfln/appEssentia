import 'dart:convert';
import 'package:front_end/pages/reminders_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class RemindersAddPage extends StatefulWidget {
  final String? reminder;
  final String? details;
  final String? observations;
  final TimeOfDay? time;
  final String? reminderId;
  final List reminders;

  const RemindersAddPage({super.key, this.reminder, this.details, this.observations, this.time, this.reminderId, required this.reminders});

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
    tz.initializeTimeZones();
    if (widget.reminder != null) {
      _titleController.text = widget.reminder!;
      _detailsController.text = widget.details ?? '';
      _observationsController.text = widget.observations ?? '';
      _selectedTime = widget.time;
    }
  }

  Future<void> _sendReminder() async {
    String title = _titleController.text;
    String details = _detailsController.text;
    String observations = _observationsController.text;
    DateTime now = DateTime.now();
    final saoPaulo = tz.getLocation('America/Sao_Paulo');
    DateTime alarmDateTime = _selectedTime != null
        ? tz.TZDateTime(saoPaulo, now.year, now.month, now.day, _selectedTime!.hour, _selectedTime!.minute)
        : tz.TZDateTime(saoPaulo, now.year, now.month, now.day, now.hour, now.minute);

    String alarmTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(alarmDateTime);
    final Map<String, dynamic> data = {
      'title': title,
      'description': details,
      'observations': observations,
      'timetable': alarmTime,
    };

    final Uri url = widget.reminderId != null
        ? Uri.parse('http://localhost:3333/api/v1/reminders/${widget.reminderId}')
        : Uri.parse('http://localhost:3333/api/v1/reminders');

    final response = await (widget.reminderId != null
        ? http.put(url, headers: {'Content-Type': 'application/json'}, body: jsonEncode(data))
        : http.post(url, headers: {'Content-Type': 'application/json'}, body: jsonEncode(data)));
    print(jsonEncode(data));
    if (response.statusCode == (widget.reminderId != null ? 200 : 201)) {
      if (widget.reminderId == null) {
        widget.reminders.add(data);
      } else {
        final index = widget.reminders.indexWhere((reminder) => reminder['id'] == widget.reminderId);
        widget.reminders[index] = data;
      }
      await saveRemindersToLocalStorage();
      Navigator.push(context, MaterialPageRoute(builder: (context) => RemindersPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha ao salvar lembrete')));
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

  Future<void> saveRemindersToLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    String remindersJson = json.encode(widget.reminders);
    await prefs.setString('reminders', remindersJson);
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
              maxLength: 45,
              decoration: InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _detailsController,
              maxLength: 255,
              decoration: InputDecoration(
                labelText: 'Detalhes',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () => _selectTime(context),
              child: AbsorbPointer(
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: _selectedTime != null ? _selectedTime!.format(context) : 'Selecione um horário',
                    prefixIcon: Icon(Icons.access_time),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _observationsController,
              maxLength: 255,
              decoration: InputDecoration(
                labelText: 'Observações',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                backgroundColor: Colors.grey[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                foregroundColor: Colors.white,
              ),
              onPressed: _sendReminder,
              child: Text('Salvar Lembrete'),
            ),
          ],
        ),
      ),
    );
  }
}
