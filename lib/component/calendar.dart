//import 'package:calendar_test/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  //final List<String> todos;
  final DateTime? selectedDay;
  final DateTime focusedDay;
  final OnDaySelected? onDaySelected;
  final onPageChanged;
  //final List<Color> moodMap;
  final Map<DateTime, Color> moodMap;
  //final List<todoItem> todoList;

  Calendar({
    required this.selectedDay,
    required this.focusedDay,
    required this.onDaySelected,
    required this.onPageChanged,
    required this.moodMap,
    //required this.todoList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultBoxDeco = BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(6.0),
    );
    final defaultTextStyle = TextStyle(
      color: Colors.grey[0600],
      fontWeight: FontWeight.w700,
    );

    return
       TableCalendar(
        focusedDay: focusedDay,
        firstDay: DateTime(1800),
        lastDay: DateTime(3000),
     
        headerStyle: const HeaderStyle(
          formatButtonVisible: false, // remove 2 weeks button
          titleCentered: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16.0,
          ),
        ),
     
        // custom builder
        calendarBuilders: CalendarBuilders(
           markerBuilder: (context, day, todos) =>  
     
     
              Container(
                width: 20,
                height: 10,
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                //retrieve color of a specific day for moodMap, do not display color for not focused month or when key(date) not contained in the map
                color: (day.month==focusedDay?.month)&moodMap.containsKey(day)?moodMap[day]:Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                ),
              ),
            
          
        ),
 
        // calendar style customize
          calendarStyle: CalendarStyle(
          isTodayHighlighted: true,
          markersAlignment: Alignment.bottomCenter,

     
          todayDecoration: BoxDecoration(
              color: Colors.cyan, borderRadius: BorderRadius.circular(6.0)),
     
          // DATE BOX DECORATION
          // weekdays
          defaultDecoration: defaultBoxDeco,
          // weekends
          weekendDecoration: defaultBoxDeco,
          // selected date
          selectedDecoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(
              color: Colors.deepPurple,
              width: 1.0,
            ),
          ),
     
          // DATE TEXT STYLES
          // weekday text
          defaultTextStyle: defaultTextStyle,
          // weekend text
          weekendTextStyle: defaultTextStyle,
          // selected date
          selectedTextStyle: defaultTextStyle.copyWith(
            color: Colors.deepPurple,
          ),
     
          // error
          // [problem] outside dates are set as circular shape with animation
          // [solution] make ou®tside shape to rectangle
          outsideDecoration: const BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          // [problem] page doesn't move to the date selected outside
          // [solution] change focusedDay
        ),
     
        // store input data of date selected
        onDaySelected: onDaySelected,
        onPageChanged: onPageChanged,

        // enable to select date and display
        selectedDayPredicate: (DateTime day) {
          if (selectedDay == null) {
            return false;
          }
     
          return day.year == selectedDay!.year &&
              day.month == selectedDay!.month &&
              day.day == selectedDay!.day;
        },
         );
     
  }
}