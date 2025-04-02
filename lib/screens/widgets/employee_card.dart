import 'package:employee_task/config/app_export.dart';

class EmployeeCard extends StatelessWidget {
  final Employee employee;
  final bool? isCurrent;

  const EmployeeCard({super.key, required this.employee, this.isCurrent = true});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(employee.id.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        BlocProvider.of<EmployeeBloc>(context).add(DeleteEmployee(employee.id));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppConstant.dataDeleted),
                Text(AppConstant.undo, style: TextStyle(color: AppColors.primaryColor)),
              ],
            ),
          ),
        );
      },
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        alignment: Alignment.centerRight,
        child: Icon(Icons.delete, color: Colors.white),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddEditEmployeeScreen(employee: employee, isEdit: true)),
          );
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),

          color: AppColors.backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employee.name,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(fontSize: 16.sp, color: AppColors.lightBlackColor),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.h),
                      child: Text(
                        employee.role,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp, color: AppColors.secondaryGreyColor),
                      ),
                    ),
                    Text(
                      isCurrent == true
                          ? 'From ${DateFormat('dd MMM, yyyy').format(employee.joiningDate)}'
                          : employee.endingDate != null
                          ? '${DateFormat('dd MMM, yyyy').format(employee.joiningDate)} - ${DateFormat('dd MMM, yyyy').format(employee.endingDate!)} '
                          : '-',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(fontSize: 12.sp, color: AppColors.secondaryGreyColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
