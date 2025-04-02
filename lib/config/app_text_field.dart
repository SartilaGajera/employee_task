import 'package:employee_task/config/app_export.dart';

class AppTextField extends StatelessWidget {
  final String? initialValue;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final double? fontSize;
  final IconData? prefixIcon, suffixIcon;
  final void Function()? suffixIconOnPressed, prefixIconOnPressed;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final Function(String?)? onSaved;
  final TextCapitalization? textCapitalization;
  final TextAlign? textAlign;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.prefixIcon,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.readOnly,
    this.textCapitalization,
    this.textAlign,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.initialValue,
    this.suffixIcon,
    this.suffixIconOnPressed,
    this.prefixIconOnPressed, this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly ?? false,
      controller: controller,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      keyboardType: keyboardType ?? TextInputType.text,
      validator: validator,
      onChanged: onChanged,
      onSaved: onSaved,
      onFieldSubmitted: onFieldSubmitted,
      textAlign: textAlign ?? TextAlign.start,
      inputFormatters: inputFormatters ?? [],
      cursorColor: AppColors.primaryColor,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: fontSize??16.sp, color: AppColors.lightBlackColor),
      initialValue: initialValue,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
        hintStyle: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(color: AppColors.secondaryGreyColor, fontSize: 16.sp),
        fillColor: AppColors.backgroundColor,
        filled: true,
        prefixIconConstraints: BoxConstraints(maxWidth: 35.w),
        prefixIcon: IconButton(
          onPressed: prefixIconOnPressed,
          icon: Icon(prefixIcon, size: 22.dg, color: AppColors.primaryColor),
        ),
        suffixIconConstraints: BoxConstraints(maxWidth: suffixIcon != null ? 30.w : 0.w),
        suffixIcon:
            suffixIcon != null
                ? InkWell(
                  onTap: suffixIconOnPressed,
                  child: Icon(suffixIcon, size: 35.dg, color: AppColors.primaryColor),
                )
                : SizedBox.shrink(),
        errorBorder: outlineInputBorder(isError: true, 4.r),
        focusedBorder: outlineInputBorder(4.r),
        enabledBorder: outlineInputBorder(4.r),
        border: outlineInputBorder(4.r),
      ),
    );
  }
}

OutlineInputBorder outlineInputBorder(double radius, {bool isError = false}) => OutlineInputBorder(
  borderSide: BorderSide(color: isError ? AppColors.errorColor : AppColors.borderColor),
  borderRadius: BorderRadius.circular(radius),
);
