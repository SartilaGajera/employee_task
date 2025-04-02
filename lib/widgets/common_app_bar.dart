import 'dart:io' show Platform;

import 'package:employee_task/config/app_export.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? isAction;
  final void Function()? onPressed;
  const CommonAppBar({super.key, required this.title, this.isAction, this.onPressed});
  @override
  Size get preferredSize => Size.fromHeight(60.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: AppColors.backgroundColor,
          fontSize:  18.sp,
        ),
      ),
      actions: [
        isAction == true
            ? IconButton(icon: Icon(Icons.delete_outline, color: AppColors.backgroundColor), onPressed: onPressed)
            : SizedBox(),
      ],
    );
  }
}
