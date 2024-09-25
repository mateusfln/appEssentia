import 'package:flutter/material.dart';

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
              onPressed: () {
                String title = _titleController.text;
                String details = _detailsController.text;
                String observations = _observationsController.text;
                String alarmTime = _selectedTime != null ? _selectedTime!.format(context) : 'Sem horário';
                
                print('Título: $title');
                print('Detalhes: $details');
                print('Horário do Alarme: $alarmTime');
                print('Observações: $observations');
                Navigator.pop(context);
              },
              child: Text('Salvar Lembrete'),
            ),
          ],
        ),
      ),
    );
  }
}
