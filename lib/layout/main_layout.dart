import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final body;
  const MainLayout({
    required this.body,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: IconButton(
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          icon: Image.asset(
            'asset/img/YPA_logo.png',
            scale: 5.5,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/class', (route) => route.isFirst);
            },
            icon: Icon(
              Icons.people,
              size: 35,
            ),
          ),
        ],
      ),
      body: body,
    );
  }
}
