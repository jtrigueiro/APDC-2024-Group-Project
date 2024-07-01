import 'package:adc_group_project/services/models/restaurant.dart';
import 'package:flutter/material.dart';

class ReserveScreen extends StatefulWidget {

  Restaurant restaurant;

  ReserveScreen({required this.restaurant});

  @override
  _ReserveScreenState createState() => _ReserveScreenState();
}

class _ReserveScreenState extends State<ReserveScreen> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      switchToCalendarEntryModeIcon: const Icon(Icons.calendar_today_rounded),
      switchToInputEntryModeIcon: const Icon(Icons.calendar_today_sharp),
      confirmText: 'Select',
      cancelText: 'Cancel',
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 7)),
    );
    if (picked != _selectedDate) {
      setState(() {
        _selectedDate = picked!;
      });
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
        title: Text('Reserve a Table'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select Date'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: Text('Select Time'),
            ),
            SizedBox(height: 16),
            Text(
              'Selected Date: ${_selectedDate?.toString() ?? 'Not Selected'}',
            ),
            SizedBox(height: 16),
            Text(
              'Selected Time: ${_selectedTime?.format(context) ?? 'Not Selected'}',
            ),
          ],
        ),
      ),
    );
  }
}