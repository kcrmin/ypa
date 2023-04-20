import 'package:flutter/material.dart';
// import '/components/Calender_Bar.dart';
import 'package:table_calendar/table_calendar.dart';

import 'calendar_bar.dart';






class TodoList extends StatelessWidget {
  const TodoList({    
    required this.todos,
    //required this.colorMood,
    required this.selectedDay,
    required this.focusedDay,
    required this.onDaySelected,
    required this.isCompletedList,
    required this.changeCompletionStatus,
    required this.deleteTodo,
    required this.addTodo,
    required this.moodList,
    Key? key,
  }) : super(key: key); 
  final List<String> todos;
  //final Color colorMood;
  final DateTime focusedDay; 
  final DateTime selectedDay;
  final OnDaySelected onDaySelected;
  final List<bool> isCompletedList;
  final dynamic changeCompletionStatus;
  final dynamic deleteTodo;
  final dynamic addTodo;
  final dynamic moodList;
  

bool checkAllComplete (List<bool> isCompletedList) {
  bool result= true;
  if(isCompletedList.isEmpty){
    return true;
  }else{
    for(int i =0; i<isCompletedList.length;i++){
      result = result&isCompletedList[i];
    }
  }
  return result;
  }

  @override
  Widget build(BuildContext context) {
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
                moodList: moodList,
                )
          )
        ),
          Flexible(
            flex:80,
            child:Container(
            //color:Colors.black,
            child: todos.isEmpty? 
            const Center(
              child: Text(
                'Add your Todos!',
                style: TextStyle(fontSize: 20.0),
              ),
            )
            //Todo_item
            : ListView.builder(
              shrinkWrap: true,
              itemCount: todos.length,
              itemBuilder: (BuildContext context, int index) {
                final todo = todos[index];
                bool isCompleted = isCompletedList[index];
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
                      changeCompletionStatus(isCompletedList,index);
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    secondary: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Colors.red[300],
                      onPressed: () {
                        deleteTodo(isCompletedList,todos,index);
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
            addTodo(isCompletedList,todos,todo);
          }
        },
      ),
    );
  }

}