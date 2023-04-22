import 'package:flutter/material.dart';
import 'package:ypa/component/calendar.dart';
import 'package:ypa/layout/main_layout.dart';
import 'package:ypa/screen/todo_screen.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HI"),),
      body: Calendar(
          selectedDay: selectedDay,
          focusedDay: focusedDay,
          onDaySelected: onDaySelected,
          onPageChanged: onPageChanged,
          moodList: []),
    );
  }

  onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = selectedDay;
      //log('mood screen selected day: $selectedDay');
    });
  }

  onPageChanged(DateTime focusedDay) {
    setState(() {
      this.focusedDay = focusedDay;
    });
  }

  onDoubleTap() {
    setState(() {
      onDaySelected(selectedDay, focusedDay);
      //log('mood screen selected day: $selectedDay');
    });
    //show todo_screen
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) =>
            ToDoScreen(selectedDay: selectedDay, focusedDay: focusedDay)));
  }
}
