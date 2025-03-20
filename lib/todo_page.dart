import 'package:flutter/material.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:intl/intl.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _key = GlobalKey<FormState>();
  DateTime? _selectedDateTime;
  bool _timeError = false;
  final TextEditingController _taskController = TextEditingController();

  List<Map<String, dynamic>> listTugas = [];

  void pickDateTime() {
    BottomPicker.dateTime(
      pickerTitle: Text(
        'Pilih Tanggal & Waktu',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      onSubmit: (selectedDateTime) {
        setState(() {
          _selectedDateTime = selectedDateTime;
          _timeError = false;
        });
      },
      backgroundColor: Colors.white,
    ).show(context);
  }

  void doneTask(int index, bool? value) {
    setState(() {
      listTugas[index]['isChecked'] = value!;
    });
  }

  void addData() {
    if (_selectedDateTime == null || _taskController.text.trim().isEmpty) {
      return;
    }

    setState(() {
      listTugas.add({
        'task': _taskController.text.trim(),
        'time': DateFormat('dd-MM-yyyy HH:mm').format(_selectedDateTime!),
        'isChecked': false,
      });
    });
    _taskController.clear();
    _selectedDateTime = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: const Text('Form Page'))),
    );
  }
}
