import 'package:employee_task/config/app_export.dart';

class AppFunctions {
  String dateFormat(time) {
    if (time == null) {
      return AppConstant.empNodate;
    } else if (time is DateTime) {
      return DateFormat('dd MMM, yyyy').format(time);
    }
    return DateFormat('dd MMM, yyyy').format(DateTime.parse(time));
  }

  bool isSameAsToday(DateTime selectedDate) {
    DateTime today = DateTime.now();
    return selectedDate.year == today.year && selectedDate.month == today.month && selectedDate.day == today.day;
  }

  Container placeHolderImage() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 60.w),
      child: Center(child: Image.asset(AppAssets.noEmpFound, fit: BoxFit.contain)),
    );
  }
}
