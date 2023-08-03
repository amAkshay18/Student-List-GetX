import 'package:hive_flutter/hive_flutter.dart';
part 'model.g.dart';

@HiveType(typeId: 1)
class StudentModel extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String age;
  @HiveField(2)
  final String subject;
  @HiveField(3)
  final String phone;

  StudentModel({
    required this.name,
    required this.age,
    required this.subject,
    required this.phone,
  });
}
