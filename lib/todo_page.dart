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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Form(
                key: _key,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Task Date',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              _selectedDateTime == null
                                  ? "Select a Date"
                                  : DateFormat(
                                    'dd-MM-yyyy HH:mm',
                                  ).format(_selectedDateTime!),
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                              ),
                            ),
                            if (_timeError)
                              Text(
                                'Please select a date',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                          ],
                        ),
                        IconButton(
                          color: Colors.blue,
                          onPressed: pickDateTime,
                          icon: Icon(Icons.date_range),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter some task';
                              }
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: _taskController,
                            decoration: InputDecoration(
                              labelText: "Enter your task",
                              hintText: "Your task",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        FilledButton(
                          onPressed: () {
                            setState(() {
                              _timeError = _selectedDateTime == null;
                            });
                          },
                          child: Text('Submit'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
