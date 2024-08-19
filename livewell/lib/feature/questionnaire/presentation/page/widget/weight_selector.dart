import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/questionnaire/presentation/controller/questionnaire_controller.dart';
import 'package:livewell/feature/update_weight/presentation/page/update_current_weight_screen.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';

class WeightSelector extends StatefulWidget {
  WeightSelector({Key? key}) : super(key: key);

  @override
  State<WeightSelector> createState() => _WeightSelectorState();
}

class _WeightSelectorState extends State<WeightSelector> {
  final QuestionnaireController controller = Get.find();
  double? selectedWeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 423.h,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              controller.localization.physicalInformationPage?.weightKg ?? 'Weight',
              style: TextStyle(color: const Color(0xFF000000), fontSize: 24.sp, fontWeight: FontWeight.w600),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 32.h),
              height: 207.h,
              child: WeightSelectorWidget(
                initialValue: 50,
                onChange: (p0) {
                  setState(() {
                    selectedWeight = p0;
                  });
                },
              ),
            ),
            LiveWellButton(
              label: controller.localization.onboardingPage?.confirm ?? "Confirm",
              color: const Color(0xFF8F01DF),
              textColor: Colors.white,
              onPressed: () {
                controller.weight.value = selectedWeight ?? 50;
                Get.back();
              },
            ),
          ],
        ));
  }
}
