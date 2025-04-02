import 'package:employee_task/config/app_export.dart';

enum CustomDatePickerMode { joiningDate, endingDate }

class CustomDatePicker extends StatefulWidget {
  final Function(DateTime?) onDateSelected;
  final DateTime? initialDate;
  final CustomDatePickerMode mode;

  const CustomDatePicker({super.key, required this.onDateSelected, this.initialDate, required this.mode});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime? _selectedDate;
  late DateTime _currentMonth;
  late PageController _pageController;
  bool _noDateSelected = false;

  @override
  void initState() {
    super.initState();
    _selectedDate =
        widget.mode == CustomDatePickerMode.joiningDate ? widget.initialDate ?? DateTime.now() : widget.initialDate;
    _noDateSelected = widget.initialDate == null && widget.mode == CustomDatePickerMode.endingDate;
    _currentMonth = _selectedDate != null ? DateTime(_selectedDate!.year, _selectedDate!.month) : DateTime.now();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _selectDate(DateTime? date) {
    setState(() {
      _selectedDate = date;
      _noDateSelected = date == null;
    });
  }

  void _selectNoDate() {
    setState(() {
      _selectedDate = null;
      _noDateSelected = true;
    });
  }

  void _goToPreviousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _goToNextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }

  Widget _buildDateOptions() {
    final now = DateTime.now();

    if (widget.mode == CustomDatePickerMode.joiningDate) {
      // For joining date: Today, Next Monday, Next Tuesday, After 1 week
      final nextMonday = now.add(Duration(days: (8 - now.weekday) % 7));
      final nextTuesday = now.add(Duration(days: (9 - now.weekday) % 7));
      final afterOneWeek = now.add(const Duration(days: 7));

      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _optionButton(
                    text: AppConstant.today,
                    onPressed: () => _selectDate(now),
                    isSelected: _selectedDate != null && _isSameDay(_selectedDate!, now),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _optionButton(
                    text: AppConstant.nextMonday,
                    onPressed: () => _selectDate(nextMonday),
                    isSelected: _selectedDate != null && _isSameDay(_selectedDate!, nextMonday),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.w),
            Row(
              children: [
                Expanded(
                  child: _optionButton(
                    text: AppConstant.nextTuesday,
                    onPressed: () => _selectDate(nextTuesday),
                    isSelected: _selectedDate != null && _isSameDay(_selectedDate!, nextTuesday),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _optionButton(
                    text: AppConstant.after1Week,
                    onPressed: () => _selectDate(afterOneWeek),
                    isSelected: _selectedDate != null && _isSameDay(_selectedDate!, afterOneWeek),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      // For ending date: No date, Today
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        child: Row(
          children: [
            Expanded(
              child: _optionButton(text: AppConstant.empNodate, onPressed: _selectNoDate, isSelected: _noDateSelected),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _optionButton(
                text: AppConstant.today,
                onPressed: () => _selectDate(now),
                isSelected: _selectedDate != null && _isSameDay(_selectedDate!, now),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _optionButton({required String text, required VoidCallback onPressed, required bool isSelected}) {
    return Material(
      color: isSelected ? AppColors.primaryColor : AppColors.secondaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(6.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? AppColors.backgroundColor : AppColors.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildMonthNavigator(),
        SizedBox(height: 8.w),
        _buildWeekdayHeader(),
        SizedBox(height: 8.w),
        _buildCalendarDays(),
      ],
    );
  }

  Widget _buildMonthNavigator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_left_rounded, color: AppColors.darkGreyColor, size: 30.dg),
          onPressed: _goToPreviousMonth,
          splashRadius: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            DateFormat('MMMM yyyy').format(_currentMonth),
            style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 18.sp, color: AppColors.lightBlackColor),
          ),
        ),
        IconButton(
          icon: Icon(Icons.arrow_right_rounded, color: AppColors.darkGreyColor, size: 30.dg),
          onPressed: _goToNextMonth,
          splashRadius: 20.r,
        ),
      ],
    );
  }

  Widget _buildWeekdayHeader() {
    final weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children:
          weekdays
              .map(
                (day) => SizedBox(
                  width: 30.w,
                  child: Text(
                    day,
                    style: Theme.of(
                      context,
                    ).textTheme.headlineMedium!.copyWith(fontSize: 14.sp, color: AppColors.lightBlackColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
              .toList(),
    );
  }

  Widget _buildCalendarDays() {
    final daysInMonth = DateUtils.getDaysInMonth(_currentMonth.year, _currentMonth.month);
    final firstDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final firstWeekdayOfMonth = firstDayOfMonth.weekday % 7; // 0-based, Sunday is 0

    final days = <Widget>[];

    // Add empty spaces for days before the first day of month
    for (int i = 0; i < firstWeekdayOfMonth; i++) {
      days.add(SizedBox(width: 30.w, height: 30.h));
    }

    // Add the days of the month
    for (int i = 1; i <= daysInMonth; i++) {
      final day = DateTime(_currentMonth.year, _currentMonth.month, i);
      final isSelected = _selectedDate != null && _isSameDay(_selectedDate!, day);
      final isToday = _isSameDay(DateTime.now(), day);

      days.add(
        GestureDetector(
          onTap: () => _selectDate(day),
          child: Container(
            width: 30.w,
            height: 30.h,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryColor : AppColors.transparentColor,
              border: isToday && !isSelected ? Border.all(color: AppColors.primaryColor, width: 1) : null,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '$i',
              style: TextStyle(
                color:
                    isSelected
                        ? AppColors.backgroundColor
                        : (isToday ? AppColors.primaryColor : AppColors.lightBlackColor),
              ),
            ),
          ),
        ),
      );
    }

    // Arrange days in rows for weeks
    final rows = <Widget>[];
    for (int i = 0; i < days.length; i += 7) {
      final weekDays = days.skip(i).take(7).toList();
      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:
              weekDays.length < 7
                  ? [...weekDays, ...List.generate(7 - weekDays.length, (_) => SizedBox(width: 30.w, height: 30.h))]
                  : weekDays,
        ),
      );
    }

    return Column(children: rows.map((row) => Padding(padding: EdgeInsets.only(top: 8.h), child: row)).toList());
  }

  Widget _buildFooter() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: CommonFooter(
        isShowleftWidget: true,
        value:
            _noDateSelected ? AppConstant.empNodate : DateFormat('d MMM yyyy').format(_selectedDate ?? DateTime.now()),
        onTap: () {
          widget.onDateSelected(_noDateSelected ? null : _selectedDate!);
          Navigator.pop(context, _selectedDate);
        },
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.backgroundColor,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildDateOptions(), _buildCalendar(), SizedBox(height: 25.h), _buildFooter()],
        ),
      ),
    );
  }
}
