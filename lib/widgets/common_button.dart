import 'package:employee_task/config/app_export.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final bool? isSave;
  final VoidCallback? onTap;
  const CommonButton({super.key, required this.title, this.isSave = true, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
          color: isSave == true ? AppColors.primaryColor : AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: isSave == true ? AppColors.backgroundColor : AppColors.primaryColor,
              fontSize: 15.sp,
            ),
          ),
        ),
      ),
    );
  }
}
