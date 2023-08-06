import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students_data/models/model.dart';
import 'package:students_data/screens/add_student.dart';
import 'package:students_data/screens/details_screen.dart';
import 'package:students_data/screens/edit_screen.dart';
import 'package:students_data/screens/search_screen.dart';
import '../functions/db_functions.dart';

// ignore: must_be_immutable
class ScreenHome extends StatelessWidget {
  StudentController myStudent = Get.put(
    StudentController(),
  );

  ScreenHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    myStudent.getAllStudents();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Student List'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                () => SearchScreen(),
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Obx(
        () {
          final studentList = myStudent.studentList;
          return ListView.separated(
            itemBuilder: ((context, index) {
              final data = studentList[index];
              return ListTile(
                onTap: () {
                  Get.to(
                    ScreenDetails(
                        name: data.name,
                        age: data.age,
                        subject: data.subject,
                        phone: data.phone),
                  );
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
                          Get.to(
                            () => EditScreen(
                              name: data.name,
                              age: data.age,
                              subject: data.subject,
                              phone: data.phone,
                              id: data.key,
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                        color: Colors.green,
                      ),
                      IconButton(
                        onPressed: () {
                          _showDeleteConfirmationDialog(context, data);
                        },
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              );
            }),
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
            itemCount: myStudent.studentList.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return ScreenAddStudent();
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, StudentModel data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Student'),
          content: Text('Are you sure you want to delete ${data.name}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                myStudent.deleteStudent(data.key);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
