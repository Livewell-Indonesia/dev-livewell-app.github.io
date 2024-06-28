import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/questionnaire/presentation/controller/questionnaire_controller.dart';
import 'package:livewell/feature/questionnaire/presentation/page/widget/subtitle_questionnaire.dart';
import 'package:livewell/feature/questionnaire/presentation/page/widget/title_questionnaire.dart';
import 'package:livewell/theme/design_system.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/textfield/auth_textfield.dart';

import 'calories_need_questionnaire.dart';

class HealthConditionQuestionnaire extends StatefulWidget {
  const HealthConditionQuestionnaire({super.key});

  @override
  State<HealthConditionQuestionnaire> createState() => _HealthConditionQuestionnaireState();
}

class _HealthConditionQuestionnaireState extends State<HealthConditionQuestionnaire> {
  final QuestionnaireController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        32.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: TitleQuestionnaire(
            title: QuestionnairePage.healthCondition.title(),
            color: Theme.of(context).colorScheme.secondaryDarkBlue,
          ),
        ),
        8.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SubtitleQuestionnaire(
            title: QuestionnairePage.healthCondition.subtitle(),
            isBold: false,
            color: Theme.of(context).colorScheme.disabled,
          ),
        ),
        40.verticalSpace,
        AuthTextField(
          controller: controller.healthCondition,
          hintText: null,
          labelText: "examples: diabetes, high blood pressure, gluten sensitivity, etc.",
          errorText: null,
          obscureText: false,
          borderColor: const Color(0xFFE8E7E7),
          minLines: 10,
          maxLines: 10,
          borderRadius: 16,
        ),
        const Spacer(),
        24.verticalSpace,
        LiveWellButton(
          label: 'Next',
          color: Theme.of(context).colorScheme.primaryPurple,
          textColor: Colors.white,
          onPressed: controller.healthCondition.text.isEmpty
              ? null
              : () {
                  controller.onNextTapped();
                },
        ),
        32.verticalSpace,
      ],
    ));
  }
}
