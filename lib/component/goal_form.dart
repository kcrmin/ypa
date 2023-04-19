import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter/cupertino.dart';

class GoalForm extends StatefulWidget {
  const GoalForm({Key? key}) : super(key: key);

  @override
  State<GoalForm> createState() => _GoalFormState();
}

class _GoalFormState extends State<GoalForm> {
  DateTime selectedDay = DateTime.now();

  // _Middle1
  double currentNum1 = 0;
  int percentage = 0;

  // _Middle2
  int currentNum2 = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        // border: Border.all(color: Colors.black, width: 1.0),
        color: Colors.white,
      ),
      height: 300, // _Middle1 = 250 || _Middle2 = 450
      width: 350,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _Top(
              onDateChanged: onDateChanged,
              selectedDay: selectedDay,
            ),
            // _Middle1(currentNum: currentNum1, percentage: percentage, onChanged: onNumChanged1),
            _Middle2(currentNum: currentNum2, onChanged: onNumChanged2),
            _Bottom(),
          ],
        ),
      ),
    );
  }

  onDateChanged(DateTime date) {
    setState(() {
      selectedDay = date;
    });
  }

  // _Middle1
  void onNumChanged1(double val) {
    setState(() {
      currentNum1 = val;
    });
  }

  // _Middle2
  void onNumChanged2(int val) {
    setState(() {
      currentNum2 = val;
    });
  }
}

class _Top extends StatelessWidget {
  final ValueChanged<DateTime> onDateChanged;
  final DateTime selectedDay;
  const _Top({
    required this.onDateChanged,
    required this.selectedDay,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime dueDate = DateTime(2023, 12, 31);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              width: 120,
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "Name",
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete,
                size: 30,
                color: Colors.red[400],
              ),
            )
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Due Date : ${selectedDay.year}-${selectedDay.month}-${selectedDay.day}",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height / 3,
                        child: CupertinoDatePicker(
                          minimumDate: DateTime.now(),
                          onDateTimeChanged: onDateChanged,
                          mode: CupertinoDatePickerMode.date,
                        ),
                      ),
                    );
                  },
                );
              },
              icon: Icon(Icons.calendar_month_rounded),
            )
          ],
        ),
      ],
    );
  }
}

class _Middle1 extends StatelessWidget {
  final double currentNum;
  final int percentage;
  final dynamic onChanged;

  const _Middle1({
    required this.currentNum,
    required this.percentage,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("${(currentNum * 100).toInt()}%"),
          ],
        ),
        Slider(
          divisions: 20,
          value: currentNum,
          onChanged: onChanged,
        ),
        // NumberPicker(
        //   minValue: 0,
        //   maxValue: 100,
        //   value: currentNum,
        //   axis: Axis.horizontal,
        //   onChanged: onChanged,
        //   itemHeight: 100,
        //   itemWidth: 100,
        //   step: 5,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(10),
        //     border: Border.all(color: Colors.black),
        //   ),
        // ),
      ],
    );
  }
}

class _Middle2 extends StatelessWidget {
  final int currentNum;
  final dynamic onChanged;

  const _Middle2({
    required this.currentNum,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NumberPicker(
          minValue: 0,
          maxValue: 100,
          value: currentNum,
          axis: Axis.horizontal,
          onChanged: onChanged,
          itemHeight: 100,
          itemWidth: 100,
          step: 5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black),
          ),
        ),
      ],
    );
  }
}

class _Bottom extends StatelessWidget {
  const _Bottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Confirm",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
