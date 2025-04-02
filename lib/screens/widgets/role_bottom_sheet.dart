import 'package:employee_task/config/app_export.dart';

class RoleBottomSheet extends StatelessWidget {
  RoleBottomSheet({super.key, });
  final List<String> roles = [AppConstant.designer, AppConstant.flutterDev, AppConstant.tester, AppConstant.owner];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: roles.length,
        itemBuilder: (c, i) {
          return InkWell(
            onTap: () {
              Navigator.pop(context, roles[i]);
            },
            child: Container(
              height: 52.h,
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.primaryGreyColor))),
              child: Center(
                child: Text(
                  roles[i],
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontSize: 16.sp, color: AppColors.lightBlackColor),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
