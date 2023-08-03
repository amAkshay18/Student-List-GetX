import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:students_data/models/model.dart';
import 'package:students_data/screens/add_student.dart';
import 'package:students_data/screens/details_screen.dart';
import 'package:students_data/screens/edit_screen.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  StudentController myStudent = Get.put(StudentController());

  HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    log('builder............');
    return Scaffold(
      body: GetX<StudentController>(
        // init: StudentController(),
        builder: (controller) {
          controller.getAllStudents();
          List<StudentModel> studentList = controller.studentList;

          return ListView.separated(
            itemBuilder: ((context, index) {
              final data = studentList[index];

              return ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => detailsScreen(
                            name: data.name,
                            age: data.age,
                            subject: data.subject,
                            phone: data.phone,
                          )));
                },
                leading: const CircleAvatar(),
                title: Text(data.name),
                subtitle: Text(data.age),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => EditScreen(
                                        name: data.name,
                                        age: data.age,
                                        subject: data.subject,
                                        phone: data.phone,
                                        id: data.key,
                                      )));
                        },
                        icon: const Icon(Icons.edit),
                        color: Colors.green,
                      ),
                      IconButton(
                        onPressed: () {
                          controller.deleteStudent(data.key);
                        },
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
              );
            }),
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
            itemCount: studentList.length,
          );
        },
      ),
      appBar: AppBar(title: const Text('Student Record')),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return addStudentScreen();
                },
              ),
            );
          },
          child: const Icon(Icons.add)),
    );
  }
}

class StudentController extends GetxController {
  var studentList = <StudentModel>[].obs;

  @override
  void onInit() {
    // Fetch all students when the controller initializes
    getAllStudents();
    super.onInit();
  }

  Future<void> getAllStudents() async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    // ignore: invalid_use_of_protected_member
    studentList.value.clear();
    // ignore: invalid_use_of_protected_member
    studentList.value.addAll(studentDB.values);
    update();
  }

  Future<void> deleteStudent(int id) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.delete(id);
    // Refresh the list after deletion
    getAllStudents();
    update();
  }

  Future<void> addStudent(StudentModel value) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.add(value);
    log(studentDB.values.length.toString());
    // Refresh the list after adding a student
    getAllStudents();
  }

  Future<void> editStudent(int id, StudentModel value) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.put(id, value);
    // Refresh the list after editing a student
    update();
    await getAllStudents();
  }
}
