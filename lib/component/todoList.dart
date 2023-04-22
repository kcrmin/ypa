import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ypa/util/string_color.dart';
import '../data/todo_item.dart';
import 'calendar_bar.dart';
import 'dart:developer';

class TodoList extends StatelessWidget {
  const TodoList({
    required this.todos,
    required this.selectedDay,
    required this.focusedDay,
    required this.onDaySelected,
    //required this.isCompletedList,
    required this.changeCompletionStatus, //how to change completion status in data base fron here?
    required this.deleteTodo,
    required this.addTodo,
    required this.moodList,
    Key? key,
  }) : super(key: key);
  final List<todoItem> todos;
  //final Color colorMood;
  final DateTime focusedDay;
  final DateTime selectedDay;
  final OnDaySelected onDaySelected;
  //final List<bool> isCompletedList;
  final dynamic changeCompletionStatus;
  final dynamic deleteTodo;
  final dynamic addTodo;
  final dynamic moodList;

  @override
  Widget build(BuildContext context) {
    log('todoList received selected day: $selectedDay');
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          toolbarHeight: 90,
          backgroundColor: stringColor("AEBDCA"),
          title: const Text(
            'To Do List',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 32.0,
              color: Colors.white,
            ),
          ),
        ),
      ),

      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
              height: 112,
              child: SafeArea(
                  child: CalendarBar(
                //colorMood: colorMood,
                selectedDay: selectedDay,
                focusedDay: focusedDay,
                onDaySelected: onDaySelected,
                moodList: moodList,
              ))),
          Flexible(
            flex: 80,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: !hasTodo(todos, selectedDay)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Add your To-Do!',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        SizedBox(height: 200,)
                      ],
                    )
                  //Todo_item
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: numTodo(todos, selectedDay),
                      itemBuilder: (BuildContext context, int index) {
                        final todo =
                            getTodoForDay(todos, selectedDay)[index].title;
                        bool isCompleted =
                            getTodoForDay(todos, selectedDay)[index].completed;
                        return Card(
                          color: Color(0xFFF5EFE6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 9.0),
                          child: CheckboxListTile(
                            checkboxShape:
                                const CircleBorder(eccentricity: 0.9),
                            contentPadding: const EdgeInsets.all(3),
                            checkColor: Colors.white,
                            title: Text(todo),
                            value: isCompleted,
                            onChanged: (bool? value) {
                              // setState(() {
                              //   _isCompletedList[index] = value ?? false;
                              // });
                              changeCompletionStatus(todos, selectedDay, todo);
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                            secondary: IconButton(
                              icon: const Icon(Icons.delete),
                              color: Colors.red[300],
                              onPressed: () {
                                deleteTodo(todos, selectedDay, todo);
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          )
        ],
      ),

      //Add Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: stringColor("AEBDCA"),
        child: Text(
          String.fromCharCode(Icons.add.codePoint),
          style: TextStyle(
            inherit: false,
            color: Colors.white,
            fontSize: 27.0,
            fontWeight: FontWeight.w800,
            fontFamily: Icons.add.fontFamily,
            package: Icons.add.fontPackage,
          ),
        ),
        onPressed: () async {
          final todo = await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: stringColor("F5EFE6"),
                title: const Text('New To Do'),
                content: TextField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: 'Enter your Todo',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF7895B2)),
                    ),
                  ),
                  onSubmitted: (value) {
                    Navigator.of(context).pop(value);
                  },
                  cursorColor: Color(0xFF7895B2),
                ),
              );
            },
          );
          if (todo != null) {
            addTodo(todos, selectedDay, todo);
          }
        },
      ),
    );
  }

  //return true if there is todo task on selected day
  bool hasTodo(List<todoItem> todos, DateTime selectedDay) {
    for (int i = 0; i < todos.length; i++) {
      // log('i: $i');
      // log('selected Day: $selectedDay; todo Day: ${todos[i].day}');
      if ((todos[i].day.month == selectedDay.month) &
          (todos[i].day.day == selectedDay.day)) {
        return true;
      }
    }

    return false;
  }

//num of todo on selected day
  int numTodo(List<todoItem> todos, DateTime selectedDay) {
    return getTodoForDay(todos, selectedDay).length;
  }

//reture all the todo item for the selected day
  List<todoItem> getTodoForDay(List<todoItem> todos, DateTime selectedDay) {
    List<todoItem> result = [];
    for (int i = 0; i < todos.length; i++) {
      if ((todos[i].day.month == selectedDay.month) &
          (todos[i].day.day == selectedDay.day)) {
        result.add(todos[i]);
      }
    }
    return result;
  }
}
