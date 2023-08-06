import 'package:flutter/material.dart';

// ignore: must_be_immutable, camel_case_types
class ScreenDetails extends StatelessWidget {
  String name;
  String age;
  String subject;
  String phone;

  ScreenDetails(
      {super.key,
      required this.name,
      required this.age,
      required this.subject,
      required this.phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name),
            const SizedBox(
              height: 20,
            ),
            Text(age),
            const SizedBox(
              height: 20,
            ),
            Text(subject),
            const SizedBox(
              height: 20,
            ),
            Text(phone),
          ],
        ),
      ),
    );
  }
}
