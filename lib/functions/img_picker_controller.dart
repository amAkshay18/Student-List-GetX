// import 'dart:developer';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:hive/hive.dart';
// import 'package:image_picker/image_picker.dart';

// import '../models/model.dart';
// import 'db_functions.dart';

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
