import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students_data/models/model.dart';
import '../functions/db_functions.dart';

// ignore: camel_case_types, must_be_immutable
class ScreenAddStudent extends StatelessWidget {
  ScreenAddStudent({super.key});
  File? selectedimage;
  // ignore: non_constant_identifier_names
  final student_name = TextEditingController();
// ignore: non_constant_identifier_names
  final student_age = TextEditingController();
// ignore: non_constant_identifier_names
  final student_subject = TextEditingController();
// ignore: non_constant_identifier_names
  final student_phoneNumber = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final studentController = Get.put(
      StudentController(),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Add Student Details'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: GetBuilder<StudentController>(
            builder: (controller) => Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {},
                          child: CircleAvatar(
                            radius: 40,
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(40),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/profile.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: student_name,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This needs to be filled';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: student_age,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Age'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This needs to be filled';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: student_subject,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Subject'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This needs to be filled';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: student_phoneNumber,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Phone Number'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This needs to be filled';
                        } else if (value.length < 10 || value.length > 10) {
                          return 'Invalid entry';
                        }
                        return null;
                      },
                    ),
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        StudentController().addStudent(
                          StudentModel(
                              name: student_name.text,
                              age: student_age.text,
                              subject: student_subject.text,
                              phone: student_phoneNumber.text),
                        );
                        studentController.getAllStudents();
                        Get.back();
                      } else {}
                    },
                    child: const Text('Click to save'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
