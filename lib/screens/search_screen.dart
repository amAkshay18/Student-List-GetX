import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../functions/db_functions.dart';
import 'details_screen.dart';
import 'edit_screen.dart';
import 'home_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final myStudent = Get.put(
    StudentController(),
  );

  @override
  Widget build(BuildContext context) {
    myStudent.setSearchList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: Colors.green,
        leading: InkWell(
            onTap: () {
              Get.to(ScreenHome());
            },
            child: const Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            CupertinoSearchTextField(
              onChanged: (value) {
                myStudent.search(value);
              },
            ),
            Expanded(
              child: Obx(
                () => ListView.separated(
                    itemBuilder: (context, index) {
                      final data = myStudent.searchStudentList[index];
                      // ignore: unused_local_variable
                      // File? image;
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
                        title: Text(
                          data.name,
                        ),
                        subtitle: Text(
                          data.age,
                        ),
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
                                  myStudent.deleteStudent(data.key);
                                },
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                    itemCount: myStudent.searchStudentList.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
