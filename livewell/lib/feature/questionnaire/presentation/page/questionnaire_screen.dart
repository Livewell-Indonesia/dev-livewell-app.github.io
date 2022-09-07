import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/questionnaire/presentation/controller/questionnaire_controller.dart';
import 'package:livewell/theme/design_system.dart';
import 'package:livewell/widgets/buttons/primary_button.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class QuestionnaireScreen extends StatelessWidget {
  QuestionnaireScreen({Key? key}) : super(key: key);

  final QuestionnaireController controller = Get.put(QuestionnaireController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
          child: SafeArea(
              top: false,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) {
                  final offsetAnimation = Tween(
                    begin: const Offset(1.0, 0.0),
                    end: const Offset(0.0, 0.0),
                  ).animate(animation);

                  return ClipRect(
                    child: SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    ),
                  );
                },
                child: Obx(() {
                  switch (controller.currentPage.value) {
                    case QuestionnairePage.consent:
                      return ConsentPage(
                        key: const ValueKey(QuestionnairePage.consent),
                      );
                    case QuestionnairePage.bio:
                      return BioQuestionnaire(
                        key: const ValueKey(QuestionnairePage.bio),
                      );
                    case QuestionnairePage.heightWeight:
                      return HeightAndWeightPage(
                        key: const ValueKey(QuestionnairePage.heightWeight),
                      );
                    case QuestionnairePage.timesYouEat:
                      return TimesYouEat(
                        key: const ValueKey(QuestionnairePage.timesYouEat),
                      );
                    case QuestionnairePage.finish:
                      return FinishPage(
                        key: const ValueKey(QuestionnairePage.finish),
                      );
                  }
                }),
              )),
          onWillPop: () {
            return Future.sync(() {
              controller.onBackPressed();
              return false;
            });
          }),
    );
  }
}

class BioQuestionnaire extends StatelessWidget {
  BioQuestionnaire({Key? key}) : super(key: key);
  final QuestionnaireController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      child: Column(
        children: [
          const SizedBox(
            height: Insets.spacingLarge,
          ),
          QuestionnaireTopBar(
            currentPage: controller.currentPage.value,
          ),
          const SizedBox(
            height: 64.0,
          ),
          const Icon(
            Icons.perm_identity,
            size: 64.0,
          ),
          const SizedBox(
            height: 24.0,
          ),
          Text(
            'Your bio',
            style: TextStyles.subTitleHiEm(color: AppColors.textLoEm),
          ),
          const SizedBox(
            height: 48.0,
          ),
          Text('date of birth'),
          Obx(() {
            return QuestionnaireGrayButton(
                label: controller.dateOfBirth.value.isEmpty
                    ? 'Select date'
                    : controller.dateOfBirth.value,
                color: AppColors.primary5,
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(1900, 1, 1),
                      maxTime: DateTime(2022, 12, 31), onChanged: (date) {
                    print('change $date');
                  }, onConfirm: (date) {
                    controller.dateOfBirth.value =
                        '${date.day}-${date.month}-${date.year}';
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                });
          }),
          const Spacer(),
          PrimaryButton(
              label: 'Next', color: AppColors.primary100, onPressed: () {}),
          const SizedBox(
            height: 24.0,
          ),
        ],
      ),
    );
  }
}

class QuestionnaireGrayButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;
  const QuestionnaireGrayButton(
      {required this.label,
      required this.color,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Insets.paddingMedium),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shadowColor: Colors.transparent,
            minimumSize: const Size(double.infinity, 44),
            primary: color,
            padding: const EdgeInsets.symmetric(
                horizontal: Insets.paddingMedium,
                vertical: Insets.paddingMedium),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0))),
        child: Text(
          label,
          style: TextStyles.body(color: AppColors.textLoEm),
        ),
      ),
    );
  }
}

class QuestionnaireTopBar extends GetView<QuestionnaireController> {
  const QuestionnaireTopBar({required this.currentPage, Key? key})
      : super(key: key);
  final QuestionnairePage currentPage;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      //padding: const EdgeInsets.symmetric(horizontal: Insets.spacingLarge),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Row(
            children: [
              const Spacer(),
              Expanded(
                flex: 2.18.toInt(),
                child: Obx(() {
                  return LinearProgressIndicator(
                    value: controller.progress.value,
                    backgroundColor: AppColors.primary15,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.primary100),
                  );
                }),
              ),
              const Spacer()
            ],
          ),
          IconButton(
              padding: const EdgeInsets.only(left: 24.0),
              onPressed: () {},
              icon: Icon(
                currentPage == QuestionnairePage.bio
                    ? Icons.close
                    : Icons.arrow_back_ios,
                color: AppColors.textHiEm,
                size: 24.0,
              )),
        ],
      ),
    );
  }
}

class HeightAndWeightPage extends StatelessWidget {
  HeightAndWeightPage({Key? key}) : super(key: key);
  final QuestionnaireController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      color: Colors.blue,
      child: Column(
        children: [
          const SizedBox(
            height: Insets.spacingLarge,
          ),
          QuestionnaireTopBar(
            currentPage: controller.currentPage.value,
          ),
          Text('Height and Weight'),
          Spacer(),
          PrimaryButton(
              label: 'Submit & Login',
              color: AppColors.primary100,
              onPressed: () {
                controller.onButtonTapped();
              })
        ],
      ),
    );
  }
}

class TimesYouEat extends StatelessWidget {
  TimesYouEat({Key? key}) : super(key: key);
  final QuestionnaireController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      color: Colors.green,
      child: Column(
        children: [
          const SizedBox(
            height: Insets.spacingLarge,
          ),
          QuestionnaireTopBar(
            currentPage: controller.currentPage.value,
          ),
          Text('Times you eat'),
          Spacer(),
          PrimaryButton(
              label: 'Submit & Login',
              color: AppColors.primary100,
              onPressed: () {
                controller.onButtonTapped();
              })
        ],
      ),
    );
  }
}

class FinishPage extends StatelessWidget {
  FinishPage({Key? key}) : super(key: key);
  final QuestionnaireController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      color: Colors.amber,
      child: Column(
        children: [
          const SizedBox(
            height: Insets.spacingLarge,
          ),
          QuestionnaireTopBar(
            currentPage: controller.currentPage.value,
          ),
          Text('Finish page'),
          Spacer(),
          PrimaryButton(
              label: 'Submit & Login',
              color: AppColors.primary100,
              onPressed: () {
                controller.onButtonTapped();
              })
        ],
      ),
    );
  }
}

class ConsentPage extends StatelessWidget {
  ConsentPage({
    Key? key,
  }) : super(key: key);
  final QuestionnaireController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      child: Column(
        children: [
          const SizedBox(
            height: 100.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'One Step Closer',
              style: TextStyles.titleHiEm(color: AppColors.textLoEm),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Make Livewell works for you as your health buddy by telling us about your bio data.',
              style: TextStyles.body(color: AppColors.textLoEm),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          PrimaryButton(
              label: 'Start the Questionnaire',
              color: AppColors.primary100,
              onPressed: () {
                controller.onButtonTapped();
              }),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}

class CustomPicker extends CommonPickerModel {
  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  CustomPicker({DateTime? currentTime, LocaleType? locale})
      : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();
    setLeftIndex(this.currentTime.hour);
    setMiddleIndex(this.currentTime.minute);
    setRightIndex(this.currentTime.second);
  }

  @override
  String leftStringAtIndex(int index) {
    if (index >= 0 && index < 24) {
      return digits(index, 2);
    } else {
      return '';
    }
  }

  @override
  String middleStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return digits(index, 2);
    } else {
      return '';
    }
  }

  @override
  String rightStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return '';
    }
  }

  @override
  String leftDivider() {
    return "|";
  }

  @override
  String rightDivider() {
    return "|";
  }

  @override
  List<int> layoutProportions() {
    return [1, 2, 1];
  }

  @override
  DateTime finalTime() {
    return currentTime.isUtc
        ? DateTime.utc(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            this.currentLeftIndex(),
            this.currentMiddleIndex(),
            this.currentRightIndex())
        : DateTime(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            this.currentLeftIndex(),
            this.currentMiddleIndex(),
            this.currentRightIndex());
  }
}
