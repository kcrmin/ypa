import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ypa/data/daily_mood.dart';
import 'package:ypa/screen/todo_screen.dart';
import '../component/calendar.dart';

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

  List<dailyMood> moodList = [
    dailyMood (DateTime.utc(2023, 3, 16), '7887de'),
    dailyMood (DateTime.utc(2023, 3, 9) ,'7887de'),
    dailyMood (DateTime.utc(2023, 4, 16) ,'7887de'),
    dailyMood (DateTime.utc(2023, 4, 20) ,'7887de'),
    dailyMood (DateTime.utc(2023, 4, 16) ,'7887de'),
    dailyMood (DateTime.utc(2023, 4, 22) ,'7887de'),
    dailyMood (DateTime.utc(2023, 4, 1) ,'7887de'),
    
    ];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onDoubleTap: () {
            setState(() {
              onDaySelected(selectedDay, focusedDay);
              //log('mood screen selected day: $selectedDay');
            });
            //show todo_screen
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_)=> ToDoScreen(selectedDay: selectedDay, focusedDay: focusedDay))
            );
          },
          child: Calendar(
            //todos: todos,
            selectedDay: selectedDay,
            focusedDay: focusedDay,
            onDaySelected: onDaySelected,
            onPageChanged: onPageChanged,
            moodList: moodList,
          ),
        )
      ),
    );
  }


  onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = selectedDay;
      //log('mood screen selected day: $selectedDay');
    });
  }
  onPageChanged(DateTime focusedDay){
    setState(() {
      this.focusedDay = focusedDay;
    });
  }
}

