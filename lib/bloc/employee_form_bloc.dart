import 'package:employee_task/config/app_export.dart';

abstract class EmployeeFormEvent {}

class UpdateName extends EmployeeFormEvent {
  final String name;
  UpdateName(this.name);
}

class UpdateRole extends EmployeeFormEvent {
  final String role;
  UpdateRole(this.role);
}

class UpdateJoiningDate extends EmployeeFormEvent {
  final DateTime joiningDate;
  UpdateJoiningDate(this.joiningDate);
}

class UpdateEndingingDate extends EmployeeFormEvent {
  final DateTime? endingDate;
  UpdateEndingingDate(this.endingDate);
}

class EmployeeFormState {
  final String name;
  final String role;
  final DateTime joiningDate;
  final DateTime? endingDate;

  EmployeeFormState({required this.name, required this.role, required this.joiningDate, required this.endingDate});

  EmployeeFormState copyWith({
    String? name,
    String? role,
    DateTime? joiningDate,
    DateTime? endingDate,
    bool clearEndingDate = false,
  }) {
    return EmployeeFormState(
      name: name ?? this.name,
      role: role ?? this.role,
      joiningDate: joiningDate ?? this.joiningDate,
      endingDate: clearEndingDate ? null : endingDate ?? this.endingDate,
    );
  }
}

class EmployeeFormBloc extends Bloc<EmployeeFormEvent, EmployeeFormState> {
  EmployeeFormBloc(Employee? employee)
    : super(
        EmployeeFormState(
          name: employee?.name ?? '',
          role: employee?.role ?? '',
          joiningDate: employee?.joiningDate ?? DateTime.now(),
          endingDate: employee?.endingDate,
        ),
      ) {
    on<UpdateName>((event, emit) {
      emit(state.copyWith(name: event.name));
    });

    on<UpdateRole>((event, emit) {
      emit(state.copyWith(role: event.role));
    });

    on<UpdateJoiningDate>((event, emit) {
      emit(state.copyWith(joiningDate: event.joiningDate));
    });

    on<UpdateEndingingDate>((event, emit) {
      if (event.endingDate == null) {
        emit(state.copyWith(clearEndingDate: true));
      } else {
        emit(state.copyWith(endingDate: event.endingDate));
      }
    });
  }
}
