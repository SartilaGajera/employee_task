import 'package:employee_task/config/app_export.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyColor,
      appBar: CommonAppBar(title: AppConstant.empList),
      body: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is EmployeeLoaded) {
            final currentEmployees = state.employees.where((emp) => emp.endingDate == null).toList();
            final pastEmployees = state.employees.where((emp) => emp.endingDate != null).toList();

            return currentEmployees.isEmpty && pastEmployees.isEmpty
                ? AppFunctions().placeHolderImage()
                : Column(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle(AppConstant.currentEmployees, context),
                          Expanded(
                            child:
                                currentEmployees.isEmpty
                                    ? Padding(padding: EdgeInsets.all(20.dg), child: AppFunctions().placeHolderImage())
                                    : ListView.builder(
                                      itemCount: currentEmployees.length,
                                      shrinkWrap: true,
                                      itemBuilder: (c, i) {
                                        return Column(
                                          children: [
                                            EmployeeCard(employee: currentEmployees[i]),
                                            i == currentEmployees.length
                                                ? SizedBox()
                                                : Container(height: 1.h, color: AppColors.primaryGreyColor),
                                          ],
                                        );
                                      },
                                    ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle(AppConstant.previousEmployees, context),
                          Expanded(
                            child:
                                pastEmployees.isEmpty
                                    ? Padding(padding: EdgeInsets.all(20.dg), child: AppFunctions().placeHolderImage())
                                    : ListView.builder(
                                      itemCount: pastEmployees.length,
                                      shrinkWrap: true,
                                      itemBuilder: (c, i) {
                                        return Column(
                                          children: [
                                            EmployeeCard(employee: pastEmployees[i], isCurrent: false),
                                            i == pastEmployees.length
                                                ? SizedBox()
                                                : Container(height: 1.h, color: AppColors.primaryGreyColor),
                                          ],
                                        );
                                      },
                                    ),
                          ),
                          if (currentEmployees.isNotEmpty || pastEmployees.isNotEmpty)
                            _buildSectionTitle(AppConstant.swipeLeftToDlt, context, isTitle: false),
                        ],
                      ),
                    ),
                  ],
                );
          } else {
            return AppFunctions().placeHolderImage();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        mini: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => AddEditEmployeeScreen()));
        },
        child: Icon(Icons.add, color: AppColors.backgroundColor),
      ),
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context, {bool? isTitle = true}) {
    return Padding(
      padding: EdgeInsets.all(isTitle == true ? 16.w : 20.w),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          fontSize: isTitle == true ? 16.sp : 15.sp,
          color: isTitle == true ? AppColors.primaryColor : AppColors.darkGreyColor,
        ),
      ),
    );
  }
}
