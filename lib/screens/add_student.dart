import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:students_data/models/model.dart';
import 'package:students_data/screens/homescreen.dart';

// ignore: camel_case_types
class addStudentScreen extends StatelessWidget {
  addStudentScreen({super.key});

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
    final studentController = Get.put(StudentController());
    return Scaffold(
      body: SingleChildScrollView(
        child: GetBuilder<StudentController>(
          // init: StudentController(),
          builder: (controller) => Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () async {},
                        child: CircleAvatar(
                          radius: 40,
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(40),
                            child: ClipOval(
                                child: /*  controller.selectedImage != null
                                    ? Image.file(
                                        controller.selectedImage!,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      )
                                    : */
                                    Image.asset(
                              'assets/profile.png',
                              fit: BoxFit.cover,
                            )),
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
                        border: OutlineInputBorder(), hintText: 'Phone Number'),
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        log('validata');
                        // controller.onAddStudentButtonClick(
                        //     student_name.text,
                        //     student_age.text,
                        //     student_subject.text,
                        //     student_phoneNumber.text);
                        StudentController().addStudent(StudentModel(
                            name: student_name.text,
                            age: student_age.text,
                            subject: student_subject.text,
                            phone: student_phoneNumber.text));
                        studentController.getAllStudents();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                      } else {
                        log('not submitted');
                      }
                    },
                    child: const Text('Click to save'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class ImagePickerController extends GetxController {
//   final formKey = GlobalKey<FormState>();
//   File? selectedImage;
//   // final studentName = TextEditingController();
//   // final studentAge = TextEditingController();
//   // final studentSubject = TextEditingController();
//   // final studentPhoneNumber = TextEditingController();

//   Future<void> pickImage() async {
//     var image = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (image == null) {
//       return;
//     }

//     selectedImage = File(image.path);
//     update();
//   }

//   void onAddStudentButtonClick(String studentName, String studentAge,
//       String studentSubject, String studentPhonenumber) async {
//     final name = studentName.trim();
//     final age = studentAge.trim();
//     final subject = studentSubject.trim();
//     final phone = studentPhonenumber.trim();

//     if (name.isEmpty || age.isEmpty || subject.isEmpty || phone.isEmpty) {
//       log('empty');
//     } else {
//       final student = StudentModel(
//         name: name,
//         age: age,
//         subject: subject,
//         phone: phone,
//       );
//       final studentDB = await Hive.openBox<StudentModel>('student_db');
//       await studentDB.add(student);
//       log('studentDB.values.length.toString()');
//       await getallStudents();
//     }
//   }
// }
