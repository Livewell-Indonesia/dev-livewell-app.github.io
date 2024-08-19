import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/feature/questionnaire/presentation/controller/questionnaire_controller.dart';
import 'package:livewell/feature/questionnaire/presentation/page/widget/subtitle_questionnaire.dart';
import 'package:livewell/feature/questionnaire/presentation/page/widget/title_questionnaire.dart';
import 'package:livewell/theme/design_system.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';

class GenderSelector extends StatelessWidget {
  final QuestionnaireController controller = Get.find();
  GenderSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          32.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: TitleQuestionnaire(
              title: QuestionnairePage.gender.title(),
              color: Theme.of(context).colorScheme.secondaryDarkBlue,
            ),
          ),
          8.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SubtitleQuestionnaire(
              title: QuestionnairePage.gender.subtitle(),
              isBold: false,
              color: Theme.of(context).colorScheme.disabled,
            ),
          ),
          32.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(child: genderButton(Gender.male, () {}, context)),
              Flexible(child: genderButton(Gender.female, () {}, context)),
            ],
          ),
          const Spacer(),
          LiveWellButton(
            label: controller.localization.onboardingPage?.next ?? "Next",
            color: Theme.of(context).colorScheme.primaryPurple,
            textColor: Colors.white,
            onPressed: () {
              controller.onNextTapped();
            },
          ),
          32.verticalSpace,
        ],
      ),
    );
  }

  Column genderButton(Gender gender, VoidCallback onTap, BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: 0.19.sh,
            width: 0.346.sw,
            child: Obx(() {
              return InkWell(
                onTap: () {
                  controller.selectedGender.value = gender;
                },
                child: Opacity(
                  opacity: gender == controller.selectedGender.value ? 1.0 : 0.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0).r,
                    child: Container(
                      decoration: BoxDecoration(
                        color: controller.selectedGender.value != gender
                            ? const Color(0xFFF2F1F9)
                            : gender == Gender.male
                                ? const Color(0xFFDDF235)
                                : const Color(0xFF7FE4F0),
                      ),
                      padding: const EdgeInsets.only(left: 12, right: 12, top: 20).r,
                      child: SvgPicture.asset(
                        gender == Gender.male ? Constant.imgMaleSVG : Constant.imgFemaleSVG,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
              );
            })),
        19.verticalSpace,
        Obx(() {
          return Text(
            gender.label(),
            style: TextStyle(color: gender == controller.selectedGender.value ? const Color(0xFF171433) : const Color(0xFF171433).withOpacity(0.5), fontSize: 18.sp, fontWeight: FontWeight.w600),
          );
        }),
      ],
    );
  }
}
