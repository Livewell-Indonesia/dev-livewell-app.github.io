import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/questionnaire/presentation/controller/questionnaire_controller.dart';
import 'package:livewell/feature/questionnaire/presentation/page/widget/height_selector.dart';
import 'package:livewell/feature/questionnaire/presentation/page/widget/subtitle_questionnaire.dart';
import 'package:livewell/feature/questionnaire/presentation/page/widget/title_questionnaire.dart';
import 'package:livewell/feature/questionnaire/presentation/page/widget/weight_selector.dart';
import 'package:livewell/theme/design_system.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';

class HeightWeightQuestionnaire extends StatefulWidget {
  const HeightWeightQuestionnaire({super.key});

  @override
  State<HeightWeightQuestionnaire> createState() => _HeightWeightQuestionnaireState();
}

class _HeightWeightQuestionnaireState extends State<HeightWeightQuestionnaire> {
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
            title: QuestionnairePage.heightWeight.title(),
            color: Theme.of(context).colorScheme.secondaryDarkBlue,
          ),
        ),
        8.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SubtitleQuestionnaire(
            title: QuestionnairePage.heightWeight.subtitle(),
            isBold: false,
            color: Theme.of(context).colorScheme.disabled,
          ),
        ),
        24.verticalSpace,
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Obx(() {
              return TextFieldHeightWeightWidget(
                value: controller.height.value == 0.0 ? null : '${controller.height.value} cm',
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Wrap(
                          children: [
                            Column(
                              children: [HeightSelector()],
                            ),
                          ],
                        );
                      });
                },
                hint: 'Height',
              );
            })),
        16.verticalSpace,
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Obx(() {
              return TextFieldHeightWeightWidget(
                value: controller.weight.value == 0.0 ? null : '${controller.weight.value} kg',
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Wrap(
                          children: [
                            Column(
                              children: [WeightSelector()],
                            ),
                          ],
                        );
                      });
                },
                hint: 'Weight',
              );
            })),
        const Spacer(),
        Obx(() {
          return LiveWellButton(
            label: 'Next',
            color: Theme.of(context).colorScheme.primaryPurple,
            textColor: Colors.white,
            onPressed: controller.weight.value != 0.0 && controller.height.value != 0
                ? () {
                    controller.onNextTapped();
                  }
                : null,
          );
        }),
        32.verticalSpace,
      ],
    ));
  }
}

class TextFieldHeightWeightWidget extends StatelessWidget {
  const TextFieldHeightWeightWidget({super.key, this.value, required this.onPressed, required this.hint});
  final String? value;
  final VoidCallback onPressed;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 12.0.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: const Color(0xFFE8E7E7), width: 2.0),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          children: [
            Text(
              value ?? hint,
              style: TextStyle(color: value == null ? Theme.of(context).colorScheme.secondaryDarkBlue.withOpacity(0.5) : Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_drop_down,
              size: 24,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
