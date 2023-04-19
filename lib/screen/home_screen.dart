import 'package:flutter/material.dart';
import 'package:ypa/component/date_card.dart';
import 'package:ypa/component/goal_card.dart';
import 'package:ypa/component/goal_form.dart';
import 'package:ypa/component/home_banner.dart';
import 'package:ypa/layout/main_layout.dart';
import 'package:ypa/util/goal_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainLayout(
        body: Column(
          children: [
            _Top(),
            HomeBanner(),
            _Bottom(),
          ],
        ),
      ),
    );
  }
}

class _Top extends StatelessWidget {
  const _Top({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DateCard(),
    );
  }
}

class _Bottom extends StatelessWidget {
  const _Bottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              showGoalDialog(context);
            },
            child: GoalCard(
              progress: 20,
              dueDate: DateTime(2023, 05, 01),
            ),
          ),
          IconButton(
            onPressed: () {
              showGoalDialog(context);
            },
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
