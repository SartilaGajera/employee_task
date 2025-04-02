import 'package:employee_task/config/app_export.dart';

class HiveService {
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(EmployeeAdapter());
    await Hive.openBox<Employee>(AppConstant.employeeBox);
  }

  Box<Employee> get _box => Hive.box<Employee>(AppConstant.employeeBox);

  List<Employee> getAllEmployees() {
    return _box.values.toList();
  }

  Future<void> addEmployee(Employee employee) async {
    await _box.put(employee.id, employee);
  }

  Future<void> updateEmployee(Employee employee) async {
    await _box.put(employee.id, employee);
  }

  Future<void> deleteEmployee(String id) async {
    await _box.delete(id);
  }
}
