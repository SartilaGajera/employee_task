import 'package:employee_task/config/app_export.dart';

class CommonFooter extends StatelessWidget {
  final VoidCallback? onTap;
  final String? value;
  final bool? isShowleftWidget;
  const CommonFooter({super.key, this.onTap, this.value, this.isShowleftWidget = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.h,
      decoration: BoxDecoration(border: Border(top: BorderSide(color: AppColors.primaryGreyColor))),
      child: Row(
        children: [
          Expanded(
            child:
                isShowleftWidget == true
                    ? Row(
                      children: [
                        Icon(Icons.event, color: AppColors.primaryColor),
                        SizedBox(width: 5.w),
                        Text(
                          value!,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp, color: AppColors.lightBlackColor),
                        ),
                      ],
                    )
                    : SizedBox(),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: CommonButton(title: AppConstant.cancel, isSave: false, onTap: () => Navigator.pop(context)),
                ),
                SizedBox(width: 16.w),
                Expanded(child: CommonButton(title: AppConstant.save, onTap: onTap)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
