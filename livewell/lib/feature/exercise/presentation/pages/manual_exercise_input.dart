import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/exercise/presentation/controller/exercise_controller.dart';
import 'package:livewell/feature/sleep/presentation/controller/sleep_controller.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';
import 'package:livewell/widgets/textfield/livewell_textfield.dart';

class ManualExerciseInput extends StatelessWidget {
  final ExerciseController controler = Get.find();
  ManualExerciseInput({super.key});

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: 'Add Steps',
        body: Expanded(
          child: Column(
            children: [
              40.verticalSpace,
              LiveWellTextField(
                  controller: controler.exerciseManualInput,
                  hintText: 'Step Count',
                  labelText: 'Step Count',
                  keyboardType: TextInputType.number,
                  errorText: null,
                  obscureText: false),
              20.verticalSpace,
              const Spacer(),
              LiveWellButton(
                label: 'Save',
                textColor: Colors.white,
                color: const Color(0xFF8F01DF),
                onPressed: () {
                  if (controler.exerciseManualInput.text.isNotEmpty) {
                    controler.sendExerciseDataManual();
                  }
                },
              ),
              40.verticalSpace,
            ],
          ),
        ));
  }
}
