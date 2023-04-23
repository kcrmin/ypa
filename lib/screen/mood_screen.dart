import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:ypa/component/banner.dart';
import 'package:ypa/database/drift_database.dart';
import 'package:ypa/layout/main_layout.dart';
import 'package:ypa/screen/todo_screen.dart';
import 'package:ypa/component/pie_chart.dart';

import '../component/calendar.dart';
import '../data/daily_mood.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({Key? key}) : super(key: key);

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
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
    return Scaffold(
      body: FutureBuilder<List<Mood>>(
          future: _getMoodFromDatabase(),
          builder: (context, snapshot) {
            List<int> colorIdList = [1, 1, 1, 3, 4, 5, 2, 6];
            List<DateTime> dateList = [
              DateTime(2023, 4, 23),
              DateTime(2023, 4, 24),
              DateTime(2023, 4, 25),
              DateTime(2023, 4, 26),
              DateTime(2023, 3, 23),
              DateTime(2023, 3, 15),
              DateTime(2023, 4, 29),
              DateTime(2023, 4, 20),
            ];
            // if(snapshot.hasData){
            // List<int> colorIdList = [];
            // List<DateTime> dateList = [];
            //   colorIdList = snapshot.data!.map((e) => e.colorId).toList();
            //   dateList = snapshot.data!.map((e) => e.date).toList();
            // }
            return Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 53,
                  color: Color(0xFFAEBDCA),
                ),
                _Top(
                  selectedDay: selectedDay,
                  focusedDay: focusedDay,
                  onDaySelected: onDaySelected,
                  onPageChanged: onPageChanged,
                  onDoubleTap: onDoubleTap,
                  moodList: getMoodList(colorIdList, dateList),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Banners(title: "My Mood Status"),
                const SizedBox(
                  height: 10,
                ),
                _Bottom(
                  colorIdList: colorIdList,
                  dateList: dateList,
                  focusedDay: focusedDay,
                ),
              ],
            );
          }),
    );
  }

  Future<List<Mood>> _getMoodFromDatabase() async {
    return await GetIt.I<LocalDatabase>().getMoods();
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

List<dailyMood> getMoodList(List<int> colorIdList, List<DateTime> dateList) {
  List<dailyMood> result = [];
  for (int i = 0; i < dateList.length; i++) {
    switch (colorIdList[i]) {
      case 1:
        result.add(dailyMood(dateList[i], 'f44336'));
        break;
      case 2:
        result.add(dailyMood(dateList[i], 'ff9800'));
        break;
      case 3:
        result.add(dailyMood(dateList[i], '4caf50'));
        break;
      case 4:
        result.add(dailyMood(dateList[i], '00bcd4'));
        break;
      case 5:
        result.add(dailyMood(dateList[i], '536dfe'));
        break;
      case 6:
        result.add(dailyMood(dateList[i], 'e91e63'));
        break;
    }
  }
  return result;
}

class _Top extends StatelessWidget {
  final DateTime selectedDay;
  final DateTime focusedDay;
  final onDaySelected;
  final onPageChanged;
  final GestureTapCallback onDoubleTap;
  final moodList;
  const _Top(
      {required this.selectedDay,
      required this.focusedDay,
      required this.onDaySelected,
      required this.onPageChanged,
      required this.onDoubleTap,
      required this.moodList,
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
  final List<int> colorIdList;
  final List<DateTime> dateList;
  DateTime focusedDay;

  _Bottom(
      {required this.colorIdList,
      required this.dateList,
      required this.focusedDay,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<int> monthlyMood = getMoodForMonth(colorIdList, dateList, focusedDay);
    Map<int, double> moodMap = getMoodPercentage(monthlyMood, focusedDay);
    return Expanded(
      flex: 1,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: MoodPieChart(
                radius: 80,
                angry_value: moodMap[1]!,
                frustrated_value: moodMap[2]!,
                happy_value: moodMap[3]!,
                calm_value: moodMap[4]!,
                sad_value: moodMap[5]!,
                excited_value: moodMap[6]!),
          )),
    );
  }
}

List<int> getMoodForMonth(
    List<int> colorIdList, List<DateTime> dateList, DateTime focusedDay) {
  List<int> result = [];
  int month = focusedDay.month;
  for (int i = 0; i < dateList.length; i++) {
    if (dateList[i].month == month) {
      result.add(colorIdList[i]);
    }
  }
  return result;
}

Map<int, double> getMoodPercentage(List<int> monthlyMood, DateTime focusedDay) {
  int angry_value = 0;
  int frustrated_value = 0;
  int calm_value = 0;
  int sad_value = 0;
  int excited_value = 0;
  int happy_value = 0;
  Map<int, double> result = {
    1: 0,
    2: 0,
    3: 0,
    4: 0,
    5: 0,
    6: 0,
  };
  for (int i = 0; i < monthlyMood.length; i++) {
    if (monthlyMood[i] == 1) {
      angry_value++;
    } else if (monthlyMood[i] == 2) {
      frustrated_value++;
    } else if (monthlyMood[i] == 3) {
      happy_value++;
    } else if (monthlyMood[i] == 4) {
      calm_value++;
    } else if (monthlyMood[i] == 5) {
      sad_value++;
    } else if (monthlyMood[i] == 6) {
      excited_value++;
    }
  }
  if (monthlyMood.isNotEmpty) {
    result.update(1, (value) => 100 * angry_value / monthlyMood.length);
    result.update(2, (value) => 100 * frustrated_value / monthlyMood.length);
    result.update(3, (value) => 100 * happy_value / monthlyMood.length);
    result.update(4, (value) => 100 * calm_value / monthlyMood.length);
    result.update(5, (value) => 100 * sad_value / monthlyMood.length);
    result.update(6, (value) => 100 * excited_value / monthlyMood.length);
  }
  return result;
}
