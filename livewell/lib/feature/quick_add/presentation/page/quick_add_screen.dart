import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/food/presentation/pages/food_screen.dart';
import 'package:livewell/feature/profile/presentation/page/account_settings_screen.dart';
import 'package:livewell/feature/quick_add/presentation/controller/quick_add_controller.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';

class QuickAddScreen extends StatefulWidget {
  const QuickAddScreen({super.key});

  @override
  State<QuickAddScreen> createState() => _QuickAddScreenState();
}

class _QuickAddScreenState extends State<QuickAddScreen> {
  final QuickAddController controller = Get.put(QuickAddController());

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: "Quick Add",
        body: Expanded(
          child: Column(
            children: [
              24.verticalSpace,
              AccountSettingsTextField(
                textEditingController: controller.foodName,
                hintText: 'Food Name',
                labelColor: const Color(0xFF808080),
                textColor: Colors.black,
              ),
              16.verticalSpace,
              AccountSettingsTextField(
                textEditingController: controller.calories,
                hintText: 'Calories (kcal)',
                labelColor: const Color(0xFF808080),
                textColor: Colors.black,
                inputType: TextInputType.number,
              ),
              16.verticalSpace,
              AccountSettingsTextField(
                textEditingController: controller.protein,
                hintText: 'Protein (g)',
                labelColor: const Color(0xFF808080),
                textColor: Colors.black,
                inputType: TextInputType.number,
              ),
              16.verticalSpace,
              AccountSettingsTextField(
                textEditingController: controller.fat,
                hintText: 'Fat (g)',
                labelColor: const Color(0xFF808080),
                textColor: Colors.black,
                inputType: TextInputType.number,
              ),
              16.verticalSpace,
              AccountSettingsTextField(
                textEditingController: controller.carbs,
                hintText: 'Carbs (g)',
                labelColor: const Color(0xFF808080),
                textColor: Colors.black,
                inputType: TextInputType.number,
              ),
              const Spacer(),
              Obx(() {
                return LiveWellButton(
                  label: 'Submit',
                  color: const Color(0xFFDDF235),
                  onPressed: controller.formValid.value
                      ? () {
                          controller.postData(MealTime.values.byName(
                              (Get.arguments['type'] as String? ??
                                      MealTime.breakfast.name)
                                  .toLowerCase()));
                        }
                      : null,
                );
              }),
              32.verticalSpace,
            ],
          ),
        ));
  }
}
