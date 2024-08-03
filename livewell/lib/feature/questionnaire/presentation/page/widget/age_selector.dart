import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/questionnaire/presentation/controller/questionnaire_controller.dart';
import 'package:livewell/feature/questionnaire/presentation/page/widget/subtitle_questionnaire.dart';
import 'package:livewell/feature/questionnaire/presentation/page/widget/title_questionnaire.dart';
import 'package:livewell/theme/design_system.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';

class AgeSelector extends StatefulWidget {
  AgeSelector({Key? key}) : super(key: key);

  @override
  State<AgeSelector> createState() => _AgeSelectorState();
}

class _AgeSelectorState extends State<AgeSelector> {
  final QuestionnaireController controller = Get.find();

  late final DateTime _minDate;

  late final DateTime _maxDate;

  late DateTime _selecteDate;

  @override
  void initState() {
    final currentDate = DateTime.now();
    _minDate = DateTime(
      currentDate.year - 100,
      currentDate.month,
      currentDate.day,
    );
    _maxDate = DateTime.now();
    _selecteDate = _maxDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          32.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: TitleQuestionnaire(
              title: QuestionnairePage.birthDate.title(),
              color: Theme.of(context).colorScheme.secondaryDarkBlue,
            ),
          ),
          8.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SubtitleQuestionnaire(
              title: QuestionnairePage.birthDate.subtitle(),
              isBold: false,
              color: Theme.of(context).colorScheme.disabled,
            ),
          ),
          32.verticalSpace,
          // SizedBox(
          //   height: 210.h,
          //   child: CupertinoTheme(
          //     data: CupertinoThemeData(
          //         textTheme: CupertinoTextThemeData(
          //       dateTimePickerTextStyle: TextStyle(
          //         fontSize: 16.sp,
          //         color: Theme.of(context).colorScheme.secondaryDarkBlue,
          //       ),
          //     )),
          //     child: CupertinoDatePicker(
          //       itemExtent: 50.h,
          //       mode: CupertinoDatePickerMode.date,
          //       initialDateTime: DateTime(2000),
          //       maximumDate: DateTime.now(),
          //       onDateTimeChanged: (DateTime newDateTime) {
          //         //controller.onAgeChanged(newDateTime);
          //       },
          //     ),
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SizedBox(
                height: 210.h,
                child: Obx(() {
                  return CustomCupertinoDatePicker(
                    itemExtent: 50.h,
                    minDate: _minDate,
                    maxDate: _maxDate,
                    selectedDate: controller.date.value,
                    selectionOverlay: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: const BoxDecoration(
                        border: Border.symmetric(
                          horizontal: BorderSide(color: Colors.grey, width: 1),
                        ),
                      ),
                    ),
                    selectedStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primaryPurple,
                      fontWeight: FontWeight.w600,
                      fontSize: 36.sp,
                    ),
                    unselectedStyle: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 24.sp,
                    ),
                    disabledStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 24.sp,
                    ),
                    onSelectedItemChanged: (date) => _selecteDate = date,
                  );
                })),
          ),
          const Spacer(),
          LiveWellButton(
            label: 'Next',
            color: Theme.of(context).colorScheme.primaryPurple,
            textColor: Colors.white,
            onPressed: () {
              controller.date.value = _selecteDate;
              controller.onNextTapped();
            },
          ),
          32.verticalSpace,
        ],
      ),
    );
  }
}

class CustomCupertinoDatePicker extends StatefulWidget {
  final double itemExtent;
  final Widget selectionOverlay;
  final double diameterRatio;
  final Color? backgroundColor;
  final double offAxisFraction;
  final bool useMaginifier;
  final double magnification;
  final double squeeze;
  final void Function(DateTime) onSelectedItemChanged;
  // Text style of selected item
  final TextStyle? selectedStyle;
  // Text style of unselected item
  final TextStyle? unselectedStyle;
  // Text style of disabled item
  final TextStyle? disabledStyle;
  // Minimum selectable date
  final DateTime? minDate;
  // Maximum selectable date
  final DateTime? maxDate;
  // Initially selected date
  final DateTime? selectedDate;
  const CustomCupertinoDatePicker({
    Key? key,
    required this.itemExtent,
    required this.onSelectedItemChanged,
    this.minDate,
    this.maxDate,
    this.selectedDate,
    this.selectedStyle,
    this.unselectedStyle,
    this.disabledStyle,
    this.backgroundColor,
    this.squeeze = 1.45,
    this.diameterRatio = 1.1,
    this.magnification = 1.0,
    this.offAxisFraction = 0.0,
    this.useMaginifier = false,
    this.selectionOverlay = const CupertinoPickerDefaultSelectionOverlay(),
  }) : super(key: key);
  @override
  State<CustomCupertinoDatePicker> createState() => _CustomCupertinoDatePickerState();
}

class _CustomCupertinoDatePickerState extends State<CustomCupertinoDatePicker> {
  late DateTime _minDate;
  late DateTime _maxDate;
  late DateTime _selectedDate;
  late int _selectedDayIndex;
  late int _selectedMonthIndex;
  late int _selectedYearIndex;
  late final FixedExtentScrollController _dayScrollController;
  late final FixedExtentScrollController _monthScrollController;
  late final FixedExtentScrollController _yearScrollController;
  final _days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  final _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  Widget _selector({
    required List<dynamic> values,
    required int selectedValueIndex,
    required bool Function(int) isDisabled,
    required void Function(int) onSelectedItemChanged,
    required FixedExtentScrollController scrollController,
  }) {
    return CupertinoPicker.builder(
      childCount: values.length,
      squeeze: widget.squeeze,
      itemExtent: widget.itemExtent,
      scrollController: scrollController,
      useMagnifier: widget.useMaginifier,
      diameterRatio: widget.diameterRatio,
      magnification: widget.magnification,
      backgroundColor: widget.backgroundColor,
      offAxisFraction: widget.offAxisFraction,
      selectionOverlay: null,
      onSelectedItemChanged: onSelectedItemChanged,
      itemBuilder: (context, index) => Container(
        height: widget.itemExtent,
        alignment: Alignment.center,
        child: Text(
          '${values[index]}',
          style: index == selectedValueIndex
              ? widget.selectedStyle
              : isDisabled(index)
                  ? widget.disabledStyle
                  : widget.unselectedStyle,
        ),
      ),
    );
  }

  bool _isLeapYear() {
    final year = _minDate.year + _selectedYearIndex;
    return year % 4 == 0 && (year % 100 != 0 || (year % 100 == 0 && year % 400 == 0));
  }

  /// get number of days for the selected month
  int _numberOfDays() {
    if (_selectedMonthIndex == 1) {
      _days[1] = _isLeapYear() ? 29 : 28;
    }
    return _days[_selectedMonthIndex];
  }

  /// check if the given day, month or year index is disabled
  bool _isDisabled(int index, _SelectorType type) {
    DateTime temp;
    switch (type) {
      case _SelectorType.day:
        temp = DateTime(
          _minDate.year + _selectedYearIndex,
          _selectedMonthIndex + 1,
          index + 1,
        );
        break;
      case _SelectorType.month:
        temp = DateTime(
          _minDate.year + _selectedYearIndex,
          index + 1,
          _selectedDayIndex + 1,
        );
        break;
      case _SelectorType.year:
        temp = DateTime(
          _minDate.year + index,
          _selectedMonthIndex + 1,
          _selectedDayIndex + 1,
        );
        break;
    }
    return temp.isAfter(_maxDate) || temp.isBefore(_minDate);
  }

  void _onSelectedItemChanged(int index, _SelectorType type) {
    DateTime temp;
    switch (type) {
      case _SelectorType.day:
        temp = DateTime(
          _minDate.year + _selectedYearIndex,
          _selectedMonthIndex + 1,
          index + 1,
        );
        break;
      case _SelectorType.month:
        temp = DateTime(
          _minDate.year + _selectedYearIndex,
          index + 1,
          _selectedDayIndex + 1,
        );
        break;
      case _SelectorType.year:
        temp = DateTime(
          _minDate.year + index,
          _selectedMonthIndex + 1,
          _selectedDayIndex + 1,
        );
        break;
    }

    // return if selected date is not the min - max date range
    // scroll selector back to the valid point
    if (temp.isBefore(_minDate) || temp.isAfter(_maxDate)) {
      switch (type) {
        case _SelectorType.day:
          _dayScrollController.jumpToItem(_selectedDayIndex);
          break;
        case _SelectorType.month:
          _monthScrollController.jumpToItem(_selectedMonthIndex);
          break;
        case _SelectorType.year:
          _yearScrollController.jumpToItem(_selectedYearIndex);
          break;
      }
      return;
    }
    // update selected date
    _selectedDate = temp;
    // adjust other selectors when one selctor is changed
    switch (type) {
      case _SelectorType.day:
        _selectedDayIndex = index;
        break;
      case _SelectorType.month:
        _selectedMonthIndex = index;
        // if month is changed to february &
        // selected day is greater than 29,
        // set the selected day to february 29 for leap year
        // else to february 28
        if (_selectedMonthIndex == 1 && _selectedDayIndex > 27) {
          _selectedDayIndex = _isLeapYear() ? 28 : 27;
        }
        // if selected day is 31 but current selected month has only
        // 30 days, set selected day to 30
        if (_selectedDayIndex == 30 && _days[_selectedMonthIndex] == 30) {
          _selectedDayIndex = 29;
        }
        break;
      case _SelectorType.year:
        _selectedYearIndex = index;
        // if selected month is february & selected day is 29
        // But now year is changed to non-leap year
        // set the day to february 28
        if (!_isLeapYear() && _selectedMonthIndex == 1 && _selectedDayIndex == 28) {
          _selectedDayIndex = 27;
        }
        break;
    }
    setState(() {});
    widget.onSelectedItemChanged(_selectedDate);
  }

  Widget _daySelector() {
    return _selector(
      values: List.generate(_numberOfDays(), (index) => index + 1),
      selectedValueIndex: _selectedDayIndex,
      scrollController: _dayScrollController,
      isDisabled: (index) => _isDisabled(index, _SelectorType.day),
      onSelectedItemChanged: (v) => _onSelectedItemChanged(
        v,
        _SelectorType.day,
      ),
    );
  }

  Widget _monthSelector() {
    return _selector(
      values: _months,
      selectedValueIndex: _selectedMonthIndex,
      scrollController: _monthScrollController,
      isDisabled: (index) => _isDisabled(index, _SelectorType.month),
      onSelectedItemChanged: (v) => _onSelectedItemChanged(
        v,
        _SelectorType.month,
      ),
    );
  }

  Widget _yearSelector() {
    return _selector(
      values: List.generate(
        _maxDate.year - _minDate.year + 1,
        (index) => _minDate.year + index,
      ),
      selectedValueIndex: _selectedYearIndex,
      scrollController: _yearScrollController,
      isDisabled: (index) => _isDisabled(index, _SelectorType.year),
      onSelectedItemChanged: (v) => _onSelectedItemChanged(
        v,
        _SelectorType.year,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _monthSelector()),
        Expanded(child: _daySelector()),
        Expanded(child: _yearSelector()),
      ],
    );
  }

  void _scrollList(FixedExtentScrollController controller, int index) {
    controller.animateToItem(
      index,
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _initDates() {
    final currentDate = DateTime.now();
    _minDate = widget.minDate ?? DateTime(currentDate.year - 100);
    _maxDate = widget.maxDate ?? DateTime(currentDate.year + 100);
    if (widget.selectedDate != null) {
      _selectedDate = widget.selectedDate!;
    } else if (!currentDate.isBefore(_minDate) && !currentDate.isAfter(_maxDate)) {
      _selectedDate = currentDate;
    } else {
      _selectedDate = _minDate;
    }
    _selectedDayIndex = _selectedDate.day - 1;
    _selectedMonthIndex = _selectedDate.month - 1;
    _selectedYearIndex = _selectedDate.year - _minDate.year;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollList(_dayScrollController, _selectedDayIndex);
      _scrollList(_monthScrollController, _selectedMonthIndex);
      _scrollList(_yearScrollController, _selectedYearIndex);
    });
  }

  @override
  void initState() {
    super.initState();
    _validateDates();
    _dayScrollController = FixedExtentScrollController();
    _monthScrollController = FixedExtentScrollController();
    _yearScrollController = FixedExtentScrollController();
    _initDates();
  }

  void _validateDates() {
    if (widget.minDate != null && widget.maxDate != null) {
      assert(!widget.minDate!.isAfter(widget.maxDate!));
    }
    if (widget.minDate != null && widget.selectedDate != null) {
      assert(!widget.minDate!.isAfter(widget.selectedDate!));
    }
    if (widget.maxDate != null && widget.selectedDate != null) {
      assert(!widget.selectedDate!.isAfter(widget.maxDate!));
    }
  }
}

enum _SelectorType { day, month, year }
