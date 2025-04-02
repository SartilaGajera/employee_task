import 'package:employee_task/config/app_export.dart';

part 'employee.g.dart';

/* @HiveType(typeId: 0)
enum Role {
  @HiveField(0)
  designer,
  
  @HiveField(1)
  manager,
  
  @HiveField(2)
  leader
} */

@HiveType(typeId: 0)
class Employee extends HiveObject{
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String role;

  @HiveField(3)
  final DateTime joiningDate;

  @HiveField(4)
  final DateTime? endingDate;

  Employee({required this.id, required this.name, required this.role, required this.joiningDate, this.endingDate});

  Employee copyWith({String? id, String? name, String? role, DateTime? joiningDate, DateTime? endingDate}) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      joiningDate: joiningDate ?? this.joiningDate,
      endingDate: endingDate ?? this.endingDate,
    );
  }
}
