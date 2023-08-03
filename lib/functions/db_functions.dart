import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:students_data/models/model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);
Future<void> addStudent(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.add(value);
  print('studentDB.values.length.toString()');
  await getallStudents();
}

Future<void> getallStudents() async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');

  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentDB.values);

  studentListNotifier.notifyListeners();
}

Future<void> deleteStudents(int id) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.delete(id);
  getallStudents();
}

Future<void> editStudents(int id, StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.put(id, value);
  studentListNotifier.notifyListeners();
  getallStudents();
}
