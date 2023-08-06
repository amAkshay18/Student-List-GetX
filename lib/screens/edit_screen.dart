import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:students_data/models/model.dart';
import '../functions/db_functions.dart';

// ignore: must_be_immutable
class EditScreen extends StatefulWidget {
  final int id;
  String name;
  String age;
  String subject;
  String phone;

  EditScreen({
    super.key,
    required this.name,
    required this.age,
    required this.subject,
    required this.phone,
    required this.id,
  });

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final myStudent = Get.put(StudentController());
  File? selectedimage;
  // ignore: non_constant_identifier_names
  final student_nameEdit = TextEditingController();
// ignore: non_constant_identifier_names
  final student_ageEdit = TextEditingController();
// ignore: non_constant_identifier_names
  final student_subjectEdit = TextEditingController();
// ignore: non_constant_identifier_names
  final student_phoneNumberEdit = TextEditingController();

  @override
  Widget build(BuildContext context) {
    student_nameEdit.text = widget.name;
    student_ageEdit.text = widget.age;
    student_subjectEdit.text = widget.subject;
    student_phoneNumberEdit.text = widget.phone;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Edit'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: CircleAvatar(
                        radius: 40,
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(40),
                          child: ClipOval(
                            child: selectedimage != null
                                ? Image.file(
                                    selectedimage!,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
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
                  controller: student_nameEdit,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: student_ageEdit,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Age'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: student_subjectEdit,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Subject'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: student_phoneNumberEdit,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Phone Number'),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  final data = StudentModel(
                      name: student_nameEdit.text,
                      age: student_ageEdit.text,
                      subject: student_subjectEdit.text,
                      phone: student_phoneNumberEdit.text);
                  myStudent.editStudent(widget.id, data);
                  Get.back();
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getImage() async {
    XFile? image;
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    final imageTemporary = File(image.path);
    setState(
      () {
        selectedimage = imageTemporary;
      },
    );
  }
}
