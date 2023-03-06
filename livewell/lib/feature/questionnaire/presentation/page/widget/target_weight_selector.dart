import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/update_weight/presentation/page/update_current_weight_screen.dart';

import '../../controller/questionnaire_controller.dart';

class TargetWeightSelector extends StatelessWidget {
  final QuestionnaireController controller = Get.find();
  TargetWeightSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 298.h,
        child: WeightSelectorWidget(
          onChange: (p0) {
            controller.targetWeight.value = p0;
          },
        ));
  }
}
