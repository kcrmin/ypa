import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final onTextSaved;
  final String title;
  const CustomText({
    required this.onTextSaved,
    required this.title,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (String? val) {
        if (val == null || val.isEmpty) {
          return "Enter Something";
        } else {
          return null;
        }
      },
      initialValue: title ?? "Hi",
      onSaved: onTextSaved,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: "Name",
        hintStyle: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
