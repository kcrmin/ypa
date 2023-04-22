//import 'package:calendar_test/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../data/daily_mood.dart';
import '../util/string_color.dart';

class CalendarBar extends StatelessWidget {
  final DateTime? selectedDay;
  final DateTime focusedDay;
  final OnDaySelected? onDaySelected;
  final List<dailyMood> moodList;

  const CalendarBar({
    required this.selectedDay,
    required this.focusedDay,
    required this.onDaySelected,
     required this.moodList,
    //required this.todos,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //List <String> _todos = todos;
    final defaultBoxDeco = BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(6.0),
    );
    final defaultTextStyle = TextStyle(
      color: Colors.grey[0600],
      fontWeight: FontWeight.w700,
    );

    return TableCalendar(
      headerVisible: false,
      focusedDay: focusedDay,
      firstDay: DateTime(1800),
      lastDay: DateTime(3000),
      calendarFormat: CalendarFormat.week,
      

      // custom builder
      calendarBuilders: CalendarBuilders(
         markerBuilder: (context, day, todos) =>  


            Container(                 
              width: 20,
              height: 10,
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
               color: (day.month==focusedDay.month)&(hasMood(moodList,day)!=-1)?stringColor(moodList[hasMood(moodList,day)].color):Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              ),
            ),
          
        
      ),


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
    //returns the index of dailyMood if mood is recorded for day, else return -1
  int hasMood (List<dailyMood> moodList, DateTime day) {
    for(int i=0; i<moodList.length; i++){
      if((moodList[i].day.month==day.month)&(moodList[i].day.day==day.day)){
        return i;
      }
    }
    return -1;
  }
}