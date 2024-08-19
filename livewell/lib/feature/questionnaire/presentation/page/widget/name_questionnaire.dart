import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/questionnaire/presentation/controller/questionnaire_controller.dart';
import 'package:livewell/feature/questionnaire/presentation/page/widget/subtitle_questionnaire.dart';
import 'package:livewell/feature/questionnaire/presentation/page/widget/title_questionnaire.dart';
import 'package:livewell/theme/design_system.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/textfield/auth_textfield.dart';

class NameQuestionnaire extends StatefulWidget {
  NameQuestionnaire({super.key});

  @override
  State<NameQuestionnaire> createState() => _NameQuestionnaireState();
}

class _NameQuestionnaireState extends State<NameQuestionnaire> {
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
              title: QuestionnairePage.name.title(),
              color: Theme.of(context).colorScheme.secondaryDarkBlue,
            ),
          ),
          8.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SubtitleQuestionnaire(
              title: QuestionnairePage.name.subtitle(),
              isBold: false,
              color: Theme.of(context).colorScheme.disabled,
            ),
          ),
          24.verticalSpace,
          AuthTextField(
            controller: controller.firstName,
            hintText: null,
            labelText: controller.localization.onboardingPage?.firstName ?? "First Name",
            errorText: null,
            obscureText: false,
            borderColor: const Color(0xFFE8E7E7),
          ),
          16.verticalSpace,
          AuthTextField(
            controller: controller.lastName,
            hintText: null,
            labelText: controller.localization.onboardingPage?.lastName ?? "Last Name",
            errorText: null,
            obscureText: false,
            borderColor: const Color(0xFFE8E7E7),
          ),
          const Spacer(),
          Obx(() {
            return LiveWellButton(
              label: controller.localization.onboardingPage?.next ?? "Next",
              color: Theme.of(context).colorScheme.primaryPurple,
              onPressed: controller.isNameValid.value
                  ? () {
                      controller.onNextTapped();
                    }
                  : null,
              textColor: Colors.white,
            );
          }),
          32.verticalSpace,
        ],
      ),
    );
  }
}
