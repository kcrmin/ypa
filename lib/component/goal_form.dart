import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:ypa/database/drift_database.dart';

class GoalForm extends StatefulWidget {
  final int? selectedGoalId;
  const GoalForm({
    this.selectedGoalId,
    Key? key,
  }) : super(key: key);

  @override
  State<GoalForm> createState() => _GoalFormState();
}

class _GoalFormState extends State<GoalForm> {
  final GlobalKey<FormState> formKey = GlobalKey();
  int? selectedGoalIdNum;
  String title = "";
  DateTime duedate = DateTime.now();

  // _Middle1
  double currentNum1 = 0;
  int percentage = 0;

  // _Middle2
  int currentNum2 = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Goal>(
        future: widget.selectedGoalId == null
            ? null
            : GetIt.I<LocalDatabase>().getGoalById(widget.selectedGoalId!),
        builder: (context, snapshot) {
          if (snapshot.hasData && this.selectedGoalIdNum == null) {
            this.selectedGoalIdNum = widget.selectedGoalId;
            this.duedate = snapshot.data!.dueDate;
            this.currentNum2 = snapshot.data!.progress;
            this.title = snapshot.data!.title;
          };

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
                    selectedDay: duedate,
                    initTitle: title,
                    onTextChanged: onTextChanged,
                    formKey: formKey,
                  ),
                  // _Middle1(currentNum: currentNum1, percentage: percentage, onChanged: onNumChanged1),
                  _Middle2(currentNum: currentNum2, onChanged: onNumChanged2),
                  _Bottom(
                    title: this.title,
                    dueDate: this.duedate,
                    progress: this.percentage,
                    onConfirmPressed: onConfirmPressed,
                  ),
                ],
              ),
            ),
          );
        });
  }

  onTextChanged(String val) {
    setState(() {
      this.title = val;
    });
  }

  onConfirmPressed() {
    print("Create");
    if (widget.selectedGoalId == null && formKey.currentState!.validate()) {
      Navigator.of(context).pop();
      return GetIt.I<LocalDatabase>().createGoal(GoalsCompanion(
        title: Value(this.title),
        dueDate: Value(this.duedate),
        progress: Value(this.currentNum2),
      ));
    }
    if (widget.selectedGoalId != null && formKey.currentState!.validate()) {
      print("update");
      Navigator.of(context).pop();
      return GetIt.I<LocalDatabase>().updateGoalById(
        widget.selectedGoalId!,
        GoalsCompanion(
          title: Value(this.title),
          dueDate: Value(this.duedate),
          progress: Value(this.currentNum2),
        ),
      );
    }
  }

  onDateChanged(DateTime date) {
    setState(() {
      this.duedate = date;
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
      this.currentNum2 = val;
    });
  }
}

class _Top extends StatelessWidget {
  final ValueChanged<DateTime> onDateChanged;
  final DateTime selectedDay;
  final String initTitle;
  final onTextChanged;
  final formKey;
  const _Top({
    required this.onDateChanged,
    required this.selectedDay,
    required this.initTitle,
    required this.onTextChanged,
    required this.formKey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String selectedDayString =
        "${selectedDay.year}-${selectedDay.month}-${selectedDay.day}";

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              width: 120,
              child: Form(
                key: formKey,
                child: TextFormField(
                  validator: (String? val){
                    if(val == null || val.isEmpty){
                      return "Enter Something";
                    } else {
                      return null;
                    }
                  },
                  onChanged: onTextChanged,
                  initialValue: initTitle,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Name",
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
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
                "Due Date : ${selectedDayString}",
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
  final String title;
  final DateTime dueDate;
  final int progress;
  final onConfirmPressed;
  const _Bottom({
    required this.title,
    required this.dueDate,
    required this.progress,
    required this.onConfirmPressed,
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
              onPressed: onConfirmPressed,
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
