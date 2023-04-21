import 'package:flutter/material.dart';
import 'package:ypa/data/todo_item.dart';

import '../component/todoList.dart';


class ToDoScreen extends StatefulWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay= DateTime.now();
  
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
   Map<DateTime,Color> moodMap = {
              DateTime.utc(2023, 3, 16) : Colors.red,
              DateTime.utc(2023, 3, 18) : Colors.red,
              DateTime.utc(2023, 4, 1) : Colors.red,
              DateTime.utc(2023, 4, 1) : Colors.red,
              DateTime.utc(2023, 4, 2) : Colors.blue,
              DateTime.utc(2023, 4, 3) : Colors.orange,
              DateTime.utc(2023, 4, 4) : Colors.red,
              DateTime.utc(2023, 4, 5) : Colors.pink,
              DateTime.utc(2023, 4, 6) : Colors.indigoAccent,
            };
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
              changeCompletionStatus: changeCompletionStatus,
              deleteTodo: deleteTodo,
              addTodo: addTodo,
              moodMap: moodMap,
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