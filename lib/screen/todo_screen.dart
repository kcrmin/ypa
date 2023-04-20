import 'package:flutter/material.dart';

import '../component/todoList.dart';


class ToDoScreen extends StatefulWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay= DateTime.now();
  List<bool> isCompletedList = [true, false, true,true, false, true,true, false, true];
  List<String> todos = ['assignment 1', 'study for midterm', 'washing dishes','1','2','3','4','5','6'];
  List<Color> moodList=[Colors.green, Colors.red, Colors.blue,Colors.yellow,Colors.orange,Colors.green, Colors.red, Colors.blue,Colors.yellow,Colors.orange,Colors.green, Colors.red, Colors.blue,Colors.yellow,Colors.orange];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: 
        Center(
          child: 
            TodoList(
              todos: todos,
              selectedDay: selectedDay,
              focusedDay:focusedDay,
              onDaySelected: onDaySelected,
              isCompletedList: isCompletedList,
              changeCompletionStatus: changeCompletionStatus,
              deleteTodo: deleteTodo,
              addTodo: addTodo,
              moodList: moodList,
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
  changeCompletionStatus(List<bool> isCompletedList, int index){
    setState(() {
      isCompletedList[index] = !isCompletedList[index];
    });
  }
  deleteTodo(List<bool> isCompletedList, List<String> todos, int index){
    setState(() {
      todos.removeAt(index);
      isCompletedList.removeAt(index);
    });
  }

  addTodo(List<bool> isCompletedList, List<String> todos, String todo){
     setState(() {
      todos.add(todo);
      isCompletedList.add(false);
    });
  }
}