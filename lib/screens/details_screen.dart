import 'package:flutter/material.dart';

// ignore: must_be_immutable, camel_case_types
class detailsScreen extends StatelessWidget {
  String name;
  String age;
  String subject;
  String phone;

  detailsScreen(
      {super.key,
      required this.name,
      required this.age,
      required this.subject,
      required this.phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 203, 207, 158),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name),
            Text(age),
            Text(subject),
            Text(phone),
          ],
        ),
      ),
    );
  }
}
