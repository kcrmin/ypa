import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class CalenderBar extends StatelessWidget {

  final List<String> todos;
  final Color colorMood;
  final DateTime focusedDay;
  final DateTime? selectedDay;
  OnDaySelected? onDaySelected;

  CalenderBar({
    required this.todos,
    required this.colorMood,
    required this.selectedDay,
    required this.focusedDay,
    required this.onDaySelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TableCalendar(
        headerVisible: false,
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2029, 12, 31),
        focusedDay: focusedDay,
        calendarFormat: CalendarFormat.week,
        selectedDayPredicate: (DateTime day) {
          if (selectedDay == null) {
            return false;
          }
          return day.year == selectedDay!.year &&
              day.month == selectedDay!.month &&
              day.day == selectedDay!.day;
        },
        calendarStyle:
        const CalendarStyle(
          markersAlignment: Alignment.bottomRight,
        ),
        calendarBuilders: CalendarBuilders(

          markerBuilder: (context, day, _todos) => todos.isNotEmpty?
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colorMood,//todos.isNotEmpty?  colorMood: Colors.white,
            ),
            child: Text(
              '${todos.length}',
              style: const TextStyle(color: Colors.white),
            ),
          )
              : null,
        ),
        onDaySelected: onDaySelected,
      ),
    );
  }
}


