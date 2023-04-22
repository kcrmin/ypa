import 'package:flutter/material.dart';
import 'package:ypa/component/date_card.dart';
import 'package:ypa/component/goal_card.dart';
import 'package:ypa/component/goal_form.dart';
import 'package:ypa/component/home_banner.dart';
import 'package:ypa/layout/main_layout.dart';
import 'package:ypa/screen/todo_screen.dart';
import 'package:ypa/util/goal_dialog.dart';
import 'package:ypa/component/pie_chart.dart';

import '../component/calendar.dart';
import '../data/daily_mood.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  List<dailyMood> moodList = [
    dailyMood(DateTime.utc(2023, 3, 16), '7887de'),
    dailyMood(DateTime.utc(2023, 3, 9), '7887de'),
    dailyMood(DateTime.utc(2023, 4, 16), '7887de'),
    dailyMood(DateTime.utc(2023, 4, 20), '7887de'),
    dailyMood(DateTime.utc(2023, 4, 16), '7887de'),
    dailyMood(DateTime.utc(2023, 4, 22), '7887de'),
    dailyMood(DateTime.utc(2023, 4, 1), '7887de'),
  ];

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: Column(
        children: [
          _Top(
            selectedDay: selectedDay,
            focusedDay: focusedDay,
            onDaySelected: onDaySelected,
            onPageChanged: onPageChanged,
            onDoubleTap: onDoubleTap,
          ),
          HomeBanner(),
          _Bottom(),
        ],
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

class _Top extends StatelessWidget {
  final DateTime selectedDay;
  final DateTime focusedDay;
  final onDaySelected;
  final onPageChanged;
  final GestureTapCallback onDoubleTap;
  const _Top(
      {required this.selectedDay,
      required this.focusedDay,
      required this.onDaySelected,
      required this.onPageChanged,
      required this.onDoubleTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: onDoubleTap,
      child: Calendar(
        //todos: todos,
        selectedDay: selectedDay,
        focusedDay: focusedDay,
        onDaySelected: onDaySelected,
        onPageChanged: onPageChanged,
        moodList: moodList,
      ),
    );
  }
}

class _Bottom extends StatelessWidget {
  const _Bottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: 3,
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 8.0,
            );
          },
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                showGoalDialog(context);
              },
              child: GoalCard(
                name: "Hi",
                progress: 20,
                dueDate: DateTime(2023, 05, 01),
              ),
            );
          },
        ),
      ),
    );
  }
}
