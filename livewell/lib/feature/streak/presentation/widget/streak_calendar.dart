import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:livewell/theme/design_system.dart';

class StreakCalendarItemModel {
  final DateTime date;
  final bool isCompleted;

  StreakCalendarItemModel({required this.date, required this.isCompleted});

  copyWith({DateTime? date, bool? isCompleted}) {
    return StreakCalendarItemModel(date: date ?? this.date, isCompleted: isCompleted ?? this.isCompleted);
  }
}

class StreakCalendar extends StatelessWidget {
  final List<StreakCalendarItemModel> streakDates;
  final DateTime selectedDate;
  final void Function(DateTime) onDateSelected;
  const StreakCalendar({super.key, required this.streakDates, required this.selectedDate, required this.onDateSelected});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: streakDates.map((e) {
        return InkWell(
            onTap: e.date.isAfter(DateTime.now()) ? () {} : () => onDateSelected(e.date),
            child: CalendarItem(date: e.date.day.toString(), isCompleted: e.isCompleted, isDateSelected: e.date.day == selectedDate.day, isInFuture: e.date.isAfter(DateTime.now())));
      }).toList(),
    );
  }
}

class CalendarItem extends StatelessWidget {
  final String date;
  final bool isCompleted;
  final bool isDateSelected;
  final bool isInFuture;
  const CalendarItem({super.key, required this.date, required this.isCompleted, required this.isDateSelected, required this.isInFuture});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
                //padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.textBg,
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2.w,
                    color: isCompleted
                        ? Theme.of(context).colorScheme.primaryPurple
                        : isInFuture
                            ? Theme.of(context).colorScheme.disabled.withOpacity(0.15)
                            : Theme.of(context).colorScheme.disabled,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0.w),
                  child: Text(date,
                      style: TextStyle(
                          color: isCompleted
                              ? Theme.of(context).colorScheme.primaryPurple
                              : isInFuture
                                  ? Theme.of(context).colorScheme.disabled.withOpacity(0.15)
                                  : Theme.of(context).colorScheme.disabled,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700)),
                )),
            isCompleted
                ? Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 12.h,
                      width: 12.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.primaryPurple,
                      ),
                      child: Icon(
                        Icons.check,
                        size: 12,
                        color: Theme.of(context).colorScheme.textBg,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
        8.verticalSpace,
        isDateSelected
            ? Container(
                height: 2.h,
                width: 32.w,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: isCompleted ? Theme.of(context).colorScheme.primaryPurple : Theme.of(context).colorScheme.disabled,
                ),
              )
            : Container(
                height: 2.h,
              )
      ],
    );
  }
}
