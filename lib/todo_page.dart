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

      backgroundColor: Colors.white,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: const Text('Form Page'))),
    );
  }
}
