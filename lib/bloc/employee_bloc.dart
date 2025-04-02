import 'package:employee_task/services/hive_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'employee_event.dart';
import 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final HiveService _hiveService;

  EmployeeBloc(this._hiveService) : super(EmployeeInitial()) {
    on<LoadEmployees>((event, emit) {
      emit(EmployeeLoading());
      final employees = _hiveService.getAllEmployees();
      emit(EmployeeLoaded(employees));
    });

    on<AddEmployee>((event, emit) async {
      await _hiveService.addEmployee(event.employee);
      add(LoadEmployees());
    });

    on<UpdateEmployee>((event, emit) async {
      await _hiveService.updateEmployee(event.employee);
      add(LoadEmployees());
    });

    on<DeleteEmployee>((event, emit) async {
      await _hiveService.deleteEmployee(event.id);
      add(LoadEmployees());
    });
  }
}
