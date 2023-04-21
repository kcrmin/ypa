import 'package:flutter/material.dart';
import '../component/calendar.dart';

import 'dart:developer';

// Angry - Colors.red
// Frustrated - Colors.orange
// Happy - Colors.green
// Calm - Colors.cyan
// Sad - Colors.indigoAccent
// Excited - Colors.pink

class MoodScreen extends StatefulWidget {
  const MoodScreen({Key? key}) : super(key: key);

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay= DateTime.now();
  //List<bool> isCompletedList = [true, false, true,true, false, true,true, false, true];
  //List<String> todos = ['assignment 1', 'study for midterm', 'washing dishes','1','2','3','4','5','6'];
  Map<DateTime,Color> moodMap = {
              DateTime.utc(2023, 3, 16) : Colors.red,
              DateTime.utc(2023, 3, 18) : Colors.red,
              DateTime.utc(2023, 4, 1) : Colors.red,
              DateTime.utc(2023, 4, 1) : Colors.red,
              DateTime.utc(2023, 4, 2) : Colors.blue,
              DateTime.utc(2023, 4, 3) : Colors.orange,
              DateTime.utc(2023, 4, 4) : Colors.red,
              DateTime.utc(2023, 4, 5) : Colors.pink,
              DateTime.utc(2023, 4, 6) : Colors.indigoAccent,
            };
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onDoubleTap: () {
            //show todo_screen
            Navigator.of(context).pushNamed('/todo');
          },
          child: Calendar(
            //todos: todos,
            selectedDay: selectedDay,
            focusedDay: focusedDay,
            onDaySelected: onDaySelected,
            moodMap: moodMap,
          ),
        )
      ),
    );
  }
  onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = selectedDay;
    });
  }
}