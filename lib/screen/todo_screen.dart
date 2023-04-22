import 'package:flutter/material.dart';
import 'package:ypa/data/todo_item.dart';
import '../component/todoList.dart';
import 'dart:developer';

import '../data/daily_mood.dart';

class ToDoScreen extends StatefulWidget {
  final DateTime selectedDay;
  final DateTime focusedDay;
  const ToDoScreen({
    required this.selectedDay,
    required this.focusedDay,
    Key? key}) : super(key: key);

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedDay = widget.selectedDay;
    focusedDay = widget.focusedDay;
  }

  
  List<todoItem> todos = [
    todoItem(DateTime.utc(2023, 4, 16), false, 'first todo'),
    todoItem(DateTime.utc(2023, 4, 16), false, 'second todo'),
    todoItem(DateTime.utc(2023, 4, 16), true, 'third todo'),
    todoItem(DateTime.utc(2023, 4, 16), true, 'fourth'),
    todoItem(DateTime.utc(2023, 4, 21), false, '5th'),
    todoItem(DateTime.utc(2023, 4, 21), false, '6th'),
    todoItem(DateTime.utc(2023, 3, 16), false, '7th'),
    todoItem(DateTime.utc(2023, 3, 16), false, '8th'),
  ];
  List<dailyMood> moodList = [
    dailyMood (DateTime.utc(2023, 3, 16), '7887de'),
    dailyMood (DateTime.utc(2023, 3, 9) ,'7887de'),
    dailyMood (DateTime.utc(2023, 4, 16) ,'7887de'),
    dailyMood (DateTime.utc(2023, 4, 20) ,'7887de'),
    dailyMood (DateTime.utc(2023, 4, 16) ,'7887de'),
    dailyMood (DateTime.utc(2023, 4, 22) ,'7887de'),
    dailyMood (DateTime.utc(2023, 4, 1) ,'7887de'),
    
    ];
  Widget build(BuildContext context){
    log('todo screen passed selected day: $selectedDay');
    return Scaffold(
      body: 
        Center(
          child: 
            TodoList(
              todos: todos,
              selectedDay: selectedDay,
              focusedDay:focusedDay,
              onDaySelected: onDaySelected,
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
  changeCompletionStatus(List<todoItem> todos, DateTime selectedDay, String todo){
    setState(() {
      for(int i = 0; i < todos.length; i++){
        if(todos[i].day==selectedDay&&todos[i].title==todo){
          todos[i].completed=!todos[i].completed;
        }
      }
    });
  }
  deleteTodo(List<todoItem> todos, DateTime selectedDay, String todo){
    setState(() {
      
       for(int i = 0; i < todos.length; i++){
        if(todos[i].day==selectedDay&&todos[i].title==todo){
          todos.removeAt(i);
        }}

    });
  }

  addTodo(List<todoItem> todos, DateTime selectedDay, String todo){
     setState(() {
      todos.add(todoItem(selectedDay, false, todo));
    });
  }
  
}