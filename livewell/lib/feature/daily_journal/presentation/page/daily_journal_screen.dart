import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:livewell/feature/daily_journal/presentation/controller/daily_journal_controller.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';

class DailyJournalScreen extends StatefulWidget {
  DailyJournalScreen({Key? key}) : super(key: key);

  @override
  State<DailyJournalScreen> createState() => _DailyJournalScreenState();
}

class _DailyJournalScreenState extends State<DailyJournalScreen> {
  final DailyJournalController controller = Get.put(DailyJournalController());

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: 'Daily Journal',
        allowBack: (Get.arguments as bool),
        body: Column(
          children: [
            55.verticalSpace,
            Container(
              height: 303.h,
              width: 342.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30).r,
              ),
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: 18.h, left: 24.w, right: 24.w),
                    child: Row(
                      children: [
                        Text(
                          "Eating",
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        Text("edit")
                      ],
                    ),
                  ),
                  12.verticalSpace,
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.only(left: 20.w, right: 20.w, top: 39.h),
                      color: const Color(0xFFF1F1F1),
                      child: Column(
                        children: [
                          Obx(() {
                            return DailyJournalEatingItem(
                              title: 'Breakfast',
                              time: controller.breakfastTime.value == null
                                  ? null
                                  : DateFormat('hh:mm a')
                                      .format(controller.breakfastTime.value!),
                              onPressed: () {
                                showTimePicker(context, (time) {
                                  controller.breakfastTime.value = time;
                                });
                              },
                            );
                          }),
                          20.verticalSpace,
                          Obx(() {
                            return DailyJournalEatingItem(
                              title: 'Lunch',
                              time: controller.lunchTime.value == null
                                  ? null
                                  : DateFormat('hh:mm a')
                                      .format(controller.lunchTime.value!),
                              onPressed: () {
                                showTimePicker(context, (time) {
                                  controller.lunchTime.value = time;
                                });
                              },
                            );
                          }),
                          20.verticalSpace,
                          Obx(() {
                            return DailyJournalEatingItem(
                              title: 'Dinner',
                              time: controller.dinnerTime.value == null
                                  ? null
                                  : DateFormat('hh:mm a')
                                      .format(controller.dinnerTime.value!),
                              onPressed: () {
                                showTimePicker(context, (time) {
                                  controller.dinnerTime.value = time;
                                });
                              },
                            );
                          }),
                          20.verticalSpace,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            20.verticalSpace,
            LiveWellButton(
                label: 'Save',
                color: const Color(0xFF8F01DF),
                textColor: Colors.white,
                onPressed: () {
                  controller.setTime();
                })
          ],
        ));
  }

  Future<dynamic> showTimePicker(
      BuildContext context, Function(DateTime) onConfirm) {
    DateTime temp = DateTime.now();
    return showCupertinoDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20).r,
              height: 386.h,
              child: Column(
                children: [
                  Text(
                    'Time',
                    style: TextStyle(
                        color: const Color(0xFF171433),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                    height: 274.h,
                    child: CupertinoDatePicker(
                      use24hFormat: true,
                      mode: CupertinoDatePickerMode.time,
                      onDateTimeChanged: (time) {
                        temp = time;
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                  width: 2,
                                  color:
                                      const Color(0xFF171433).withOpacity(0.7)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                            ),
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color: const Color(0xFF171433),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                            )),
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 2,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFF8F01DF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                            ),
                            onPressed: () {
                              onConfirm(temp);
                              Get.back();
                            },
                            child: Text(
                              'Save',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

class DailyJournalEatingItem extends StatelessWidget {
  final String title;
  final String? time;
  final VoidCallback onPressed;
  const DailyJournalEatingItem(
      {Key? key, required this.title, this.time, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(left: 24.w, right: 15.w),
        height: 50.h,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: const Color(0xFFDDF235), width: 3.w),
            borderRadius: BorderRadius.circular(30).r),
        child: Row(children: [
          Icon(time == null
              ? Icons.check_box_outline_blank
              : Icons.check_box_outlined),
          7.horizontalSpace,
          Text(
            title,
            style: TextStyle(
                color: const Color(0xFF171433).withOpacity(0.5),
                fontSize: 14.sp),
          ),
          const Spacer(),
          Text(
            time ?? "None",
            style: TextStyle(
                color: time == null
                    ? const Color(0xFF171433)
                    : const Color(0xFF8F01DF),
                fontWeight: FontWeight.w500,
                fontSize: 14.sp),
          )
        ]),
      ),
    );
  }
}
