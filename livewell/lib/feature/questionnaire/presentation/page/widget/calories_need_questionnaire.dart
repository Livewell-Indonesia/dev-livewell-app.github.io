import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/feature/questionnaire/presentation/controller/questionnaire_controller.dart';
import 'package:livewell/feature/questionnaire/presentation/page/widget/subtitle_questionnaire.dart';
import 'package:livewell/feature/questionnaire/presentation/page/widget/title_questionnaire.dart';
import 'package:livewell/theme/design_system.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';

class CaloriesNeedQuestionnaire extends StatefulWidget {
  const CaloriesNeedQuestionnaire({super.key});

  @override
  State<CaloriesNeedQuestionnaire> createState() => _CaloriesNeedQuestionnaireState();
}

enum CaloriesNeedType { light, moderate, active, none }

extension CaloriesNeedTypeExtension on CaloriesNeedType {
  String get title {
    switch (this) {
      case CaloriesNeedType.light:
        return Get.find<HomeController>().localization.onboardingPage?.light ?? "Light";
      case CaloriesNeedType.moderate:
        return Get.find<HomeController>().localization.onboardingPage?.moderate ?? "Moderate";
      case CaloriesNeedType.active:
        return Get.find<HomeController>().localization.onboardingPage?.active ?? "Active";
      case CaloriesNeedType.none:
        return 'None';
    }
  }

  String get calories {
    switch (this) {
      case CaloriesNeedType.light:
        return Get.find<HomeController>().localization.onboardingPage?.light100Kcal ?? "(100kcal)";
      case CaloriesNeedType.moderate:
        return Get.find<HomeController>().localization.onboardingPage?.moderate250Kcal ?? "(250kcal)";
      case CaloriesNeedType.active:
        return Get.find<HomeController>().localization.onboardingPage?.active400Kcal ?? "(400kcal)";
      case CaloriesNeedType.none:
        return 'None';
    }
  }

  int get value {
    switch (this) {
      case CaloriesNeedType.light:
        return 100;
      case CaloriesNeedType.moderate:
        return 250;
      case CaloriesNeedType.active:
        return 400;
      case CaloriesNeedType.none:
        return 0;
    }
  }

  String get subtitle {
    switch (this) {
      case CaloriesNeedType.light:
        return Get.find<HomeController>().localization.onboardingPage?.lightDescription ?? "Mostly sedentary with occasional movement";
      case CaloriesNeedType.moderate:
        return Get.find<HomeController>().localization.onboardingPage?.moderateDescription ?? "Regular exercise or physically demanding work.";
      case CaloriesNeedType.active:
        return Get.find<HomeController>().localization.onboardingPage?.activeDescription ?? "Frequent exercise and a high level of daily activity.";
      case CaloriesNeedType.none:
        return 'None';
    }
  }

  List<CaloriesNeedType> get uiValues {
    return [CaloriesNeedType.light, CaloriesNeedType.moderate, CaloriesNeedType.active];
  }
}

class _CaloriesNeedQuestionnaireState extends State<CaloriesNeedQuestionnaire> {
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
              title: QuestionnairePage.caloriesNeed.title(),
              color: Theme.of(context).colorScheme.secondaryDarkBlue,
            ),
          ),
          8.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SubtitleQuestionnaire(
              title: QuestionnairePage.caloriesNeed.subtitle(),
              isBold: false,
              color: Theme.of(context).colorScheme.disabled,
            ),
          ),
          24.verticalSpace,
          Column(
              children: CaloriesNeedType.values
                  .map(
                    (e) => (e == CaloriesNeedType.none)
                        ? const SizedBox()
                        : Obx(
                            () {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: CaloriesNeedSelectionWidget(
                                    type: e,
                                    isSelected: e == controller.selectedCaloriesNeed.value,
                                    onPressed: () {
                                      controller.selectedCaloriesNeed.value = e;
                                    }),
                              );
                            },
                          ),
                  )
                  .toList()),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          //   child: TextFieldCaloriesNeedWidget(
          //     value: null,
          //     onPressed: () {
          //       //controller.onHeightTapped();
          //     },
          //     hint: 'Calories Need',
          //   ),
          // ),
          // 16.verticalSpace,
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          //   child: TextFieldCaloriesNeedWidget(
          //     value: null,
          //     onPressed: () {
          //       //controller.onHeightTapped();
          //     },
          //     hint: 'Calories Need',
          //   ),
          // ),
          const Spacer(),
          Obx(() {
            return LiveWellButton(
              label: controller.localization.onboardingPage?.next ?? "Next",
              color: Theme.of(context).colorScheme.primaryPurple,
              textColor: Colors.white,
              onPressed: controller.selectedCaloriesNeed.value != CaloriesNeedType.none
                  ? () {
                      controller.onNextTapped();
                    }
                  : null,
            );
          }),
          32.verticalSpace,
        ],
      ),
    );
  }
}

class CaloriesNeedSelectionWidget extends StatelessWidget {
  const CaloriesNeedSelectionWidget({
    super.key,
    required this.type,
    required this.isSelected,
    required this.onPressed,
  });
  final CaloriesNeedType type;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 1.sw,
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).colorScheme.primaryGreen.withOpacity(0.1) : Colors.transparent,
          border: Border.all(
            color: isSelected ? Theme.of(context).colorScheme.primaryGreen : const Color(0xFFE8E7E7),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: type.title,
                style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              TextSpan(
                text: " ${type.calories}",
                style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w400),
              ),
            ])),
            4.verticalSpace,
            Text(
              type.subtitle,
              style: TextStyle(color: Theme.of(context).colorScheme.disabled, fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
