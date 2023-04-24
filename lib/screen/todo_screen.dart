import 'package:flutter/material.dart';
import 'package:ypa/data/todo_item.dart';
import '../component/todoList.dart';
import 'dart:developer';
import 'package:ypa/database/drift_database.dart';
import 'package:get_it/get_it.dart';
import '../data/daily_mood.dart';
import 'mood_screen.dart';

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



  Widget build(BuildContext context){
    return Scaffold(
      body: 
        FutureBuilder<List<Mood>>(
          future: null,
          builder: (context, snapshot) {
            List<int> colorIdList = [1,1,1,3,4,5,2,6];
            List<DateTime> dateList = [
            DateTime(2023,4,23),
            DateTime(2023,4,24),
            DateTime(2023,4,25),
            DateTime(2023,4,26),
            DateTime(2023,3,23),
            DateTime(2023,3,15),
            DateTime(2023,4,29),
            DateTime(2023,4,20),];
            // List<int> colorIdList = [];
            // List<DateTime> dateList = [];
            // if(snapshot.hasData){
            //   colorIdList = snapshot.data!.map((e) => e.colorId).toList();
            //   dateList = snapshot.data!.map((e) => e.date).toList();
            // }
            return Center(
              child: 
                FutureBuilder<List<Todo>>(
                  future: null,
                  builder: (context, snapshot) {
                    //List<todoItem> todos = [];
                    //  if(snapshot.hasData){
                    //     List<DateTime>todoDate = snapshot.data!.map((e) => e.date).toList();
                    //     List<bool>completedList = snapshot.data!.map((e) => e.completed).toList();
                    //     List<String>title = snapshot.data!.map((e) => e.title).toList();
                    //     for(int i=0;i<title.length;i++){
                    //       todos.add(todoItem(todoDate[i], completedList[i], title[i]));
                    //     }
                    //   }
                    List<todoItem>todos = [
                      todoItem(DateTime.utc(2023, 4, 16), false, 'first todo'),
                      todoItem(DateTime.utc(2023, 4, 16), false, 'second todo'),
                      todoItem(DateTime.utc(2023, 4, 16), true, 'third todo'),
                      todoItem(DateTime.utc(2023, 4, 16), true, 'fourth'),
                      todoItem(DateTime.utc(2023, 4, 21), false, '5th'),
                      todoItem(DateTime.utc(2023, 4, 21), false, '6th'),
                      todoItem(DateTime.utc(2023, 3, 16), false, '7th'),
                      todoItem(DateTime.utc(2023, 3, 16), false, '8th'),
                    ];
                    return TodoList(
                      todos: todos,
                      selectedDay: selectedDay,
                      focusedDay:focusedDay,
                      onDaySelected: onDaySelected,
                      changeCompletionStatus: changeCompletionStatus,
                      deleteTodo: deleteTodo,
                      addTodo: addTodo,
                      moodList: getMoodList(colorIdList, dateList),
              );
                  }
                )
            );
          }
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