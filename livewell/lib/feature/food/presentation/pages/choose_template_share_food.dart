import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/food/data/model/foods_model.dart';
import 'package:livewell/feature/food/presentation/pages/share_food_screen.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';

class ChooseTemplateShareFood extends StatefulWidget {
  const ChooseTemplateShareFood({super.key});

  @override
  State<ChooseTemplateShareFood> createState() => _ChooseTemplateShareFoodState();
}

class _ChooseTemplateShareFoodState extends State<ChooseTemplateShareFood> {
  File? file;
  Foods? food;
  TemplateType selectedTemplate = TemplateType.first;
  double? aspectRatio;
  @override
  void initState() {
    file = Get.arguments['file'];
    food = Get.arguments['food'];
    aspectRatio = Get.arguments['aspectRatio'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh,
      width: 1.sw,
      color: Color(0xFF505050),
      padding: EdgeInsets.symmetric(vertical: 20.h) + EdgeInsets.only(top: 40.h),
      child: Column(children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
            ),
            const Spacer(),
            Text(
              'Choose a template',
              style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                //Get.back();
              },
              child: Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.transparent,
                  size: 24.sp,
                ),
              ),
            ),
          ],
        ),
        32.verticalSpace,
        if (selectedTemplate == TemplateType.first)
          FirstTemplateShareFood(
            file: file!,
            food: food!,
            aspectRatio: aspectRatio!,
          ),
        if (selectedTemplate == TemplateType.second)
          SecondTemplateShareFood(
            food: food!,
            file: file!,
            aspectRatio: aspectRatio!,
          ),
        32.verticalSpace,
        TemplateSelector(
          selectedTemplate: selectedTemplate,
          onTap: (type) {
            setState(() {
              selectedTemplate = type;
            });
          },
        ),
        32.verticalSpace,
        LiveWellButton(
          label: 'Done',
          elevation: 0,
          color: Color(0xFF8F01DF),
          textColor: Colors.white,
          onPressed: () {
            AppNavigator.push(routeName: AppPages.shareFood, arguments: {
              'type': selectedTemplate,
              'file': file,
              'aspectRatio': aspectRatio,
              'food': food,
            });
          },
        )
      ]),
    );
  }
}

enum TemplateType { first, second }

class TemplateSelector extends StatefulWidget {
  TemplateType selectedTemplate = TemplateType.first;
  var onTap = (TemplateType) {};
  TemplateSelector({super.key, required this.selectedTemplate, required this.onTap});

  @override
  State<TemplateSelector> createState() => _TemplateSelectorState();
}

class _TemplateSelectorState extends State<TemplateSelector> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              widget.selectedTemplate = TemplateType.first;
              widget.onTap(widget.selectedTemplate);
            });
          },
          child: Container(
            width: 96.w,
            height: 136.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: widget.selectedTemplate == TemplateType.first ? Border.all(color: const Color(0xFF8F01DF), width: 4.w) : null,
            ),
            child: Stack(
              children: [
                Positioned(
                    top: 24,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFDDF235),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(100),
                          bottomRight: Radius.circular(100),
                        ),
                      ),
                      width: 50.w,
                      height: 30.h,
                    ))
              ],
            ),
          ),
        ),
        32.horizontalSpace,
        InkWell(
          onTap: () {
            setState(() {
              widget.selectedTemplate = TemplateType.second;
              widget.onTap(widget.selectedTemplate);
            });
          },
          child: Container(
            width: 96.w,
            height: 136.h,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: widget.selectedTemplate == TemplateType.second ? Border.all(color: const Color(0xFF8F01DF), width: 4.w) : null,
            ),
            child: ClipRRect(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                      bottom: 20,
                      child: Transform.translate(
                        offset: const Offset(-10, 0),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFF8F01DF),
                            shape: BoxShape.circle,
                          ),
                          width: 50.w,
                          height: 50.h,
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FirstTemplateShareFood extends StatelessWidget {
  final File file;
  final double aspectRatio;
  final Foods food;
  const FirstTemplateShareFood({super.key, required this.file, required this.food, required this.aspectRatio});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: aspectRatio == 1.0 ? 1.sw - 20.w : 224.5.w,
      height: aspectRatio == 1.0 ? 1.sw - 20.w : 399.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.file(
                file,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 64.h,
            child: FirstTemplateContent(
              foodName: food.foodName ?? "",
              servings: "${food.servings?.first.servingDescription ?? ""} ${food.servings?.first.servingDesc ?? ""}",
              calories: "${food.servings?[0].calories ?? ""} cal",
              fat: "${food.servings?[0].fat ?? ""} g",
              carbs: "${food.servings?[0].carbohydrate ?? ""} g",
              protein: "${food.servings?[0].protein ?? ""} g",
              containerWidth: 180.w,
            ),
          )
        ],
      ),
    );
  }
}

class SecondTemplateShareFood extends StatelessWidget {
  final File file;
  final Foods food;
  final double aspectRatio;
  const SecondTemplateShareFood({super.key, required this.file, required this.food, required this.aspectRatio});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: aspectRatio == 1.0 ? 1.sw - 20.w : 224.w,
      height: aspectRatio == 1.0 ? 1.sw - 20.w : 399.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.file(
                file,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 64,
            left: -50,
            child: SecondTemplateContent(
              foodName: food.foodName ?? "",
              servings: "${food.servings?.first.servingDescription ?? ""} ${food.servings?.first.servingDesc ?? ""}",
              calories: "${food.servings?[0].calories ?? ""} cal",
              fat: "${food?.servings?[0].fat ?? ""} g",
              carbs: "${food.servings?[0].carbohydrate ?? ""} g",
              protein: "${food.servings?[0].protein ?? ""} g",
            ),
          )
        ],
      ),
    );
  }
}
