import 'package:flutter/material.dart';
// import '/components/Calender_Bar.dart';
import 'package:table_calendar/table_calendar.dart';

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
    required this.changeCompletionStatus,//how to change completion status in data base fron here?
    required this.deleteTodo,
    required this.addTodo,
    required this.moodMap,
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
  final dynamic moodMap;
  
  @override
  Widget build(BuildContext context) {
    int bo=numTodo(todos,selectedDay);
     log('$bo');
    return Scaffold(
      
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.teal[400],
          title: const Text('To Do List'),
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
          child:
            SafeArea(
              child: CalendarBar(
                //colorMood: colorMood, 
                selectedDay: selectedDay, 
                focusedDay: focusedDay, 
                onDaySelected: onDaySelected,
                moodMap: moodMap,
                )
          )
        ),
          Flexible(
            flex:80,
            child:Container(
            child: !hasTodo(todos,selectedDay)? 
            const Center(
              child: Text(
                'Add your Todos!',
                style: TextStyle(fontSize: 20.0),
              ),
            )
            //Todo_item
            : ListView.builder(
              shrinkWrap: true,
              itemCount: numTodo(todos, selectedDay),
              itemBuilder: (BuildContext context, int index) {
                final todo = getTodoForDay(todos, selectedDay)[index].title;
                bool isCompleted = getTodoForDay(todos, selectedDay)[index].completed;
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 9.0),
                  child: CheckboxListTile(
                    checkboxShape: const CircleBorder(eccentricity: 0.9),
                    contentPadding: const EdgeInsets.all(3),
                    checkColor: Colors.white,
                    title: Text(todo),
                    value: isCompleted,
                    onChanged: (bool? value) {
                      // setState(() {
                      //   _isCompletedList[index] = value ?? false;
                      // });
                      changeCompletionStatus(todos,selectedDay,todo);
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    secondary: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Colors.red[300],
                      onPressed: () {
                        deleteTodo(todos,selectedDay,todo);
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
        backgroundColor: Colors.teal[400],
        child: const Icon(Icons.add),
        onPressed: () async {
          final todo = await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('New Todo'),
                content: TextField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: 'Enter your Todo',
                  ),
                  onSubmitted: (value) {
                    Navigator.of(context).pop(value);
                  },
                ),
              );
            },
          );
          if (todo != null) {
            addTodo(todos,selectedDay,todo);
          }
        },
      ),
    );
  }
  //return true if there is todo task on selected day
  bool hasTodo(List<todoItem> todos,DateTime selectedDay){
  for(int i = 0; i<todos.length; i++){
    // log('i: $i');
    // log('selected Day: $selectedDay; todo Day: ${todos[i].day}');
    if((todos[i].day.month==selectedDay.month) & (todos[i].day.day==selectedDay.day)){
      return true;
    }
  }
  
  return false;
}
//num of todo on selected day
  int numTodo(List<todoItem> todos,DateTime selectedDay){
    return getTodoForDay(todos, selectedDay).length;
  }
//reture all the todo item for the selected day
List<todoItem> getTodoForDay( List<todoItem> todos,DateTime selectedDay){
  List<todoItem> result = [];
  for(int i = 0; i<todos.length; i++){
    if((todos[i].day.month==selectedDay.month) & (todos[i].day.day==selectedDay.day)){
      result.add(todos[i]);
    }
  }
  return result;
}

  
}