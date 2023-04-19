import 'package:flutter/material.dart';
import 'package:ypa/layout/main_layout.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: Center(
        child: Text("Text Screen"),
      ),
    );
  }
}
