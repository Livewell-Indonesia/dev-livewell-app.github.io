import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/questionnaire/presentation/controller/questionnaire_controller.dart';

class AgeSelector extends StatelessWidget {
  final QuestionnaireController controller = Get.find();
  AgeSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 298.h,
      child: DatePickerWidget(
        initialDateTime: controller.date.value,
        onMonthChangeStartWithFirstDate: false,
        maxDateTime: DateTime.now(),
        dateFormat: 'yyyy-MMM-dd',
        onChange: (dateTime, selectedIndex) {
          controller.date.value = dateTime;
        },
        pickerTheme: const DateTimePickerTheme(
          showTitle: false,
        ),
      ),
    );
  }
}
