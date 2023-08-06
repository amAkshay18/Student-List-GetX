import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hive/hive.dart';
import 'package:students_data/models/model.dart';

class StudentController extends GetxController {
  RxList<StudentModel> studentList = <StudentModel>[].obs;
  RxList<StudentModel> searchStudentList = <StudentModel>[].obs;

  @override
  void onInit() {
    getAllStudents();
    super.onInit();
  }

  Future<void> getAllStudents() async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    // ignore: invalid_use_of_protected_member
    studentList.clear();
    // ignore: invalid_use_of_protected_member
    studentList.addAll(studentDB.values);
    // update();
  }

  Future<void> deleteStudent(int id) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.delete(id);
    await getAllStudents();
    update();
  }

  Future<void> addStudent(StudentModel value) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.add(value);
    getAllStudents();
  }

  Future<void> editStudent(int id, StudentModel value) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.put(id, value);
    update();
    await getAllStudents();
  }

  setSearchList() {
    searchStudentList = studentList;
  }

  search(String text) {
    List<StudentModel> tempList = [];
    tempList = searchStudentList
        .where(
          (element) => element.name.toLowerCase().contains(
                text.toLowerCase(),
              ),
        )
        .toList();
    searchStudentList.value = tempList;
  }
}
