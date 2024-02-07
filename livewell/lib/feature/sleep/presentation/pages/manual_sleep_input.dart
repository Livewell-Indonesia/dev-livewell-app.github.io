import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:livewell/feature/sleep/presentation/controller/sleep_controller.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';
import 'package:livewell/widgets/textfield/livewell_textfield.dart';

class ManualSleepInput extends StatelessWidget {
  final SleepController controler = Get.find();
  ManualSleepInput({super.key});

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: 'Add Sleep',
        body: Expanded(
          child: Column(
            children: [
              40.verticalSpace,
              InkWell(
                onTap: () {
                  showTimePicker(context, (time) {
                    String show = DateFormat('HH:mm a').format(time);
                    controler.manualSleepInput.text = show;
                    DateTime temp = time;
                    if (time.hour > 17) {
                      temp = DateTime(time.year, time.month, time.day - 1,
                          time.hour, time.minute);
                    }
                    controler.sleepInput.value = temp;
                  },
                      DateTime(DateTime.now().year, DateTime.now().month,
                          DateTime.now().day, 22, 0));
                },
                child: LiveWellTextField(
                    controller: controler.manualSleepInput,
                    hintText: 'Start Time of Sleep',
                    labelText: 'Start Time of Sleep',
                    keyboardType: TextInputType.number,
                    errorText: null,
                    enabled: false,
                    obscureText: false),
              ),
              20.verticalSpace,
              InkWell(
                onTap: () {
                  showTimePicker(context, (time) {
                    String show = DateFormat('HH:mm a').format(time);
                    controler.manualWakeUpInput.text = show;
                    DateTime temp = time;
                    if (time.hour > 17) {
                      temp = DateTime(time.year, time.month, time.day - 1,
                          time.hour, time.minute);
                    }
                    controler.wakeUpInput.value = temp;
                  },
                      DateTime(DateTime.now().year, DateTime.now().month,
                          DateTime.now().day, 6, 0));
                },
                child: LiveWellTextField(
                    controller: controler.manualWakeUpInput,
                    hintText: 'Wake Up Time',
                    labelText: 'Wake Up Time',
                    keyboardType: TextInputType.number,
                    errorText: null,
                    enabled: false,
                    obscureText: false),
              ),
              20.verticalSpace,
              20.verticalSpace,
              const Spacer(),
              LiveWellButton(
                label: 'Save',
                color: const Color(0xFF8F01DF),
                textColor: Colors.white,
                onPressed: () {
                  controler.sendExerciseDataManual();
                },
              ),
              40.verticalSpace,
            ],
          ),
        ));
  }

  Future<dynamic> showTimePicker(BuildContext context,
      Function(DateTime) onConfirm, DateTime initialDate) {
    DateTime temp = initialDate;
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
                    controler.localization.time!,
                    style: TextStyle(
                        color: const Color(0xFF171433),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 274.h,
                    child: CupertinoDatePicker(
                      use24hFormat: true,
                      initialDateTime: initialDate,
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
                              controler.localization.cancel!,
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 49, 46, 75),
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
                              controler.localization.save!,
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
