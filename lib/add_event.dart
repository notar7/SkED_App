import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddEvent extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? selectedDate;

  const AddEvent({
    Key? key,
    required this.firstDate,
    required this.lastDate,
    this.selectedDate,
  }) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  late DateTime _selectedDate;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate ?? DateTime.now();
    _startTime = TimeOfDay.now();
    _endTime = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Schedule',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.black, // Change background color to black
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          GestureDetector(
            onTap: () {
              _selectDate(context);
            },
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Date',
                labelStyle: TextStyle(color: Colors.greenAccent), // Change label text color to green accent
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width:3,color: Colors.greenAccent), // Change border color to green accent
                ),
              ),
              child: Text(
                DateFormat('MMMM d, yyyy').format(_selectedDate),
                style: TextStyle(color: Colors.white), // Change text color to green accent
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row( // Display startTime and endTime in one row
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _selectStartTime(context);
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Start Time',
                      labelStyle: TextStyle(color: Colors.greenAccent), // Change label text color to green accent
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width:3,color: Colors.greenAccent), // Change border color to green accent
                      ),
                    ),
                    child: Text(
                      _startTime.format(context),
                      style: TextStyle(color: Colors.white), // Change text color to green accent
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _selectEndTime(context);
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'End Time',
                      labelStyle: TextStyle(color: Colors.greenAccent), // Change label text color to green accent
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width:3,color: Colors.greenAccent), // Change border color to green accent
                      ),
                    ),
                    child: Text(
                      _endTime.format(context),
                      style: TextStyle(color: Colors.white), // Change text color to green accent
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            style: TextStyle(color: Colors.white), // Change text color to green accent
            controller: _titleController,
            maxLines: 1,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width:3,color: Colors.greenAccent),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width:3,color: Colors.greenAccent), // Change border color to green accent
              ),
              labelText: 'Title',
              labelStyle: TextStyle(color: Colors.greenAccent), // Change label text color to green accent
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            style: TextStyle(color: Colors.white), // Change text color to green accent
            controller: _descController,
            maxLines: 5,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width:3,color: Colors.greenAccent),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width:3,color: Colors.greenAccent), // Change border color to green accent
              ),
              labelText: 'Description',
              labelStyle: TextStyle(color: Colors.greenAccent), // Change label text color to green accent
            ),
          ),
          const SizedBox(height: 50),
          SizedBox(
            height: 40,
            width: 20,
            child: ElevatedButton(
              onPressed: () {
                _addEvent();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent, // Change button background color to green accent
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: const Text("Save"),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (pickedTime != null) {
      setState(() {
        _startTime = pickedTime;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _endTime,
    );
    if (pickedTime != null) {
      setState(() {
        _endTime = pickedTime;
      });
    }
  }

  void _addEvent() async {
    final title = _titleController.text;
    final description = _descController.text;
    if (title.isEmpty) {
      print('Title cannot be empty');
      return;
    }
    await FirebaseFirestore.instance.collection('events').add({
      'title': title,
      'description': description,
      'date': Timestamp.fromDate(_selectedDate),
      'startTime': DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _startTime.hour,
        _startTime.minute,
      ),
      'endTime': DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _endTime.hour,
        _endTime.minute,
      ),
    });
    if (mounted) {
      Navigator.pop<bool>(context, true);
    }
  }
}
