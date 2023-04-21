import 'package:flutter/material.dart';
import 'package:ypa/screen/classroom_screen.dart';
import 'package:ypa/screen/mood_screen.dart';
import 'screen/home_screen.dart';
import 'screen/todo_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: '/mood',
      routes: {
        '/': (context) => HomeScreen(),
        '/class': (context) => ClassroomScreen(),
        '/mood': (context) => MoodScreen(),
      },
    ),
  );
}
