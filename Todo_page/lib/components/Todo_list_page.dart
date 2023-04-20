import 'package:flutter/material.dart';
import 'package:todo_page/components/Calender_Bar.dart';
import 'package:table_calendar/table_calendar.dart';



class TodoListMinseo extends StatefulWidget {
  const TodoListMinseo({
    required this.todos,
    required this.colorMood,
    required this.selectedDay,
    required this.focusedDay,
    required this.onDaySelected,
    required this.isCompletedList,
    Key? key,
  }) : super(key: key);
  final List<String> todos;
  final Color colorMood;
  final DateTime focusedDay;
  final DateTime selectedDay;
  final OnDaySelected onDaySelected;
  final List<bool> isCompletedList;
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoListMinseo> {
  late List<String> _todos;
  late Color _colorMood;
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  OnDaySelected? _onDaySelected;
  late List<bool> _isCompletedList;

  @override
  void initState() {
    super.initState();
    _todos = widget.todos;
    _colorMood = widget.colorMood;
    _focusedDay = widget.focusedDay;
    _selectedDay = widget.selectedDay;
    _onDaySelected = widget.onDaySelected;
    _isCompletedList = widget.isCompletedList;
  }

  //Background and AppBar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
              flex:50,
              child:
              Container(
                  height: 60,
                  child: CalenderBar(
                      todos: _todos,
                      colorMood: _colorMood,
                      selectedDay: _selectedDay,
                      focusedDay: _focusedDay,
                      onDaySelected: _onDaySelected)
              )
          ),

          Expanded(
            child:SafeArea(
              child: _todos.isEmpty
                  ? const Center(

                child: Text(
                  'Add your Todos!',
                  style: TextStyle(fontSize: 20.0),
                ),
              )
              //Todo_item
                  : ListView.builder(
                shrinkWrap: true,
                itemCount: _todos.length,
                itemBuilder: (BuildContext context, int index) {
                  final todo = _todos[index];
                  bool isCompleted = _isCompletedList[index];
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
                        setState(() {
                          _isCompletedList[index] = value ?? false;
                        });
                      },

                      controlAffinity: ListTileControlAffinity.leading,
                      secondary: IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.red[300],
                        onPressed: () {
                          setState(() {
                            _todos.removeAt(index);
                            _isCompletedList.removeAt(index);
                          });
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
            setState(() {
              _todos.add(todo);
              _isCompletedList.add(false);
            });
          }
        },
      ),
    );
  }

}