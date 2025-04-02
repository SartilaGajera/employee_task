import 'package:employee_task/config/app_export.dart';

class AddEditEmployeeScreen extends StatelessWidget {
  final Employee? employee;
  final bool? isEdit;

  const AddEditEmployeeScreen({super.key, this.employee, this.isEdit = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EmployeeFormBloc(employee),
      child: EmployeeFormView(isEdit: isEdit, employee: employee),
    );
  }
}

class EmployeeFormView extends StatelessWidget {
  final bool? isEdit;
  final Employee? employee;

  EmployeeFormView({super.key, this.isEdit = false, this.employee});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<EmployeeFormBloc>();

    return Scaffold(
      appBar: CommonAppBar(title: isEdit == true ? AppConstant.editEmpDetails : AppConstant.addEmpDetails),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 24.h),
        child: BlocBuilder<EmployeeFormBloc, EmployeeFormState>(
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        AppTextField(
                          hintText: AppConstant.empNameHintText,
                          initialValue: state.name,
                          prefixIcon: Icons.person_outline,
                          textCapitalization: TextCapitalization.words,
                          onChanged: (value) => context.read<EmployeeFormBloc>().add(UpdateName(value)),
                          validator: (v) {
                            if ((v == null || v.isEmpty)) {
                              return AppConstant.empNameValidationMsg;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 22.h),
                        AppTextField(
                          controller: TextEditingController(text: state.role),
                          hintText: AppConstant.empRoleHintText,
                          readOnly: true,
                          prefixIcon: Icons.home_repair_service_outlined,
                          suffixIcon: Icons.arrow_drop_down_rounded,
                          suffixIconOnPressed: () async {
                            final value = await showModalBottomSheet(
                              context: context,
                              backgroundColor: AppColors.backgroundColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.r),
                                  topRight: Radius.circular(16.r),
                                ),
                              ),
                              builder: (context) => RoleBottomSheet(),
                            );
                            if (value != null) {
                              bloc.add(UpdateRole(value));
                            }
                          },
                          validator: (v) {
                            if ((v == null || v.isEmpty)) {
                              return AppConstant.empRoleValidationMsg;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 22.h),

                        Row(
                          children: [
                            Expanded(
                              child: BlocBuilder<EmployeeFormBloc, EmployeeFormState>(
                                builder: (context, state) {
                                  final TextEditingController joiningDateController = TextEditingController(
                                    text:
                                        AppFunctions().isSameAsToday(state.joiningDate) == true
                                            ? AppConstant.today
                                            : AppFunctions().dateFormat(state.joiningDate),
                                  );

                                  return AppTextField(
                                    controller: joiningDateController,
                                    hintText: AppConstant.today,
                                    readOnly: true,
                                    fontSize: 14.sp,
                                    prefixIcon: Icons.event,
                                    prefixIconOnPressed: () async {
                                      await showDialog(
                                        context: context,
                                        builder:
                                            (context) => CustomDatePicker(
                                              initialDate: state.joiningDate,
                                              onDateSelected: (date) {
                                                if (date != null) {
                                                  bloc.add(UpdateJoiningDate(date));
                                                }
                                                joiningDateController.text = AppFunctions().dateFormat(date);
                                              },
                                              mode: CustomDatePickerMode.joiningDate,
                                            ),
                                      );
                                    },
                                    validator: (v) {
                                      if ((v == null || v.isEmpty)) {
                                        return AppConstant.empJoiningDateValidationMsg;
                                      }
                                      return null;
                                    },
                                  );
                                },
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                              child: Icon(Icons.east, color: AppColors.primaryColor, size: 18.dg),
                            ),
                            Expanded(
                              child: BlocBuilder<EmployeeFormBloc, EmployeeFormState>(
                                builder: (context, state) {
                                  final TextEditingController endingDateController = TextEditingController(
                                    text: AppFunctions().dateFormat(state.endingDate),
                                  );

                                  return AppTextField(
                                    controller: endingDateController,
                                    hintText: AppConstant.empNodate,
                                    readOnly: true,
                                    prefixIcon: Icons.event,
                                    fontSize: 14.sp,
                                    prefixIconOnPressed: () {
                                      showDialog(
                                        context: context,
                                        builder:
                                            (context) => CustomDatePicker(
                                              initialDate: state.endingDate,
                                              onDateSelected: (date) {
                                                bloc.add(UpdateEndingingDate(date));
                                                endingDateController.text = AppFunctions().dateFormat(date);
                                              },
                                              mode: CustomDatePickerMode.endingDate,
                                            ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  CommonFooter(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState?.save();
                        final newEmployee = Employee(
                          id: employee?.id ?? Uuid().v4(),
                          name: state.name,
                          role: state.role,
                          joiningDate: state.joiningDate,
                          endingDate: state.endingDate,
                        );

                        if (isEdit == true) {
                          context.read<EmployeeBloc>().add(UpdateEmployee(newEmployee));
                        } else {
                          context.read<EmployeeBloc>().add(AddEmployee(newEmployee));
                        }
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
