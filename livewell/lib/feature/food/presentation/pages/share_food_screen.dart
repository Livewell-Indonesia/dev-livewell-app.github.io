import 'dart:io';

import 'package:appinio_social_share/appinio_social_share.dart';
import 'package:davinci/core/davinci_capture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/exercise/presentation/pages/exercise_share_page.dart';
import 'package:livewell/feature/food/data/model/foods_model.dart';
import 'package:livewell/feature/food/presentation/pages/choose_template_share_food.dart';
import 'package:path_provider/path_provider.dart';

class ShareFoodScreen extends StatefulWidget {
  const ShareFoodScreen({super.key});

  @override
  State<ShareFoodScreen> createState() => _ShareFoodScreenState();
}

class _ShareFoodScreenState extends State<ShareFoodScreen> {
  TemplateType? type;
  File? file;
  double? aspectRatio;
  Foods? food;

  @override
  void initState() {
    type = Get.arguments['type'];
    file = Get.arguments['file'];
    aspectRatio = Get.arguments['aspectRatio'];
    food = Get.arguments['food'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh,
      width: 1.sw,
      color: const Color(0xFF505050),
      padding: EdgeInsets.symmetric(vertical: 20.h) + EdgeInsets.only(top: 40.h),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: InkWell(
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
        ),
        Expanded(
          flex: 8,
          child: Column(
            children: [
              Text(
                "Share Your food with friend",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.sp, color: const Color(0xFFFFFFFF), fontWeight: FontWeight.w600),
              ),
              42.verticalSpace,
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: ShareFoodOverlayImage(
                  type: type!,
                  file: file!,
                  aspectRatio: aspectRatio!,
                  foodName: food?.foodName ?? "",
                  servings: food?.servings?[0].servingDesc ?? "",
                  calories: food?.servings?[0].calories ?? "",
                  fat: food?.servings?[0].fat ?? "",
                  carbs: food?.servings?[0].carbohydrate ?? "",
                  protein: food?.servings?[0].protein ?? "",
                ),
              ),
              30.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ShareButtonType.values.map((e) {
                  return InkWell(
                    onTap: () async {
                      EasyLoading.show();
                      final result = await DavinciCapture.offStage(
                          ShareFoodOverlayImage(
                            type: type!,
                            file: file!,
                            aspectRatio: aspectRatio!,
                            foodName: food?.foodName ?? "",
                            servings: food?.servings?[0].servingDesc ?? "",
                            calories: food?.servings?[0].calories ?? "",
                            fat: food?.servings?[0].fat ?? "",
                            carbs: food?.servings?[0].carbohydrate ?? "",
                            protein: food?.servings?[0].protein ?? "",
                          ),
                          context: context,
                          pixelRatio: Get.pixelRatio,
                          fileName: 'livewell',
                          wait: const Duration(seconds: 2),
                          returnImageUint8List: true);
                      final tempDir = await getTemporaryDirectory();
                      final files = File('${tempDir.path}/livewell.png');
                      EasyLoading.dismiss();
                      if (result != null) {
                        await files.writeAsBytes(result!);
                        switch (e) {
                          case ShareButtonType.instagram:
                            await AppinioSocialShare().shareToInstagramStory("108487895683370", backgroundImage: files.path);
                          case ShareButtonType.facebook:
                            await AppinioSocialShare().shareToFacebookStory("108487895683370", backgroundImage: files.path);
                          default:
                            await AppinioSocialShare().shareToSystem("food", "", filePath: files.path);
                        }
                      }
                    },
                    child: Container(
                      width: 40.h,
                      height: 40.h,
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          e.widget(),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.transparent,
            size: 24.sp,
          ),
        )),
      ]),
    );
  }
}

class ShareFoodOverlayImage extends StatelessWidget {
  final TemplateType type;
  final File file;
  final String foodName;
  final String servings;
  final String calories;
  final String fat;
  final String carbs;
  final String protein;
  final double aspectRatio;
  const ShareFoodOverlayImage(
      {super.key,
      required this.type,
      required this.file,
      required this.foodName,
      required this.servings,
      required this.calories,
      required this.fat,
      required this.carbs,
      required this.protein,
      required this.aspectRatio});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: aspectRatio == 1 ? 1.sw : 295.w,
      height: aspectRatio == 1 ? 1.sw : 524.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.file(
            file,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: type == TemplateType.first ? 64.h : null,
            bottom: type == TemplateType.second ? 64.h : null,
            left: type == TemplateType.second ? -10.w : null,
            child: type == TemplateType.first ? const FirstTemplateContent() : const SecondTemplateContent(),
          ),
        ],
      ),
    );
  }
}

class FirstTemplateContent extends StatelessWidget {
  const FirstTemplateContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      height: 120.h,
      decoration: BoxDecoration(
        color: const Color(0xFFDDF235),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16.r),
          bottomRight: Radius.circular(16.r),
        ),
      ),
    );
  }
}

class SecondTemplateContent extends StatelessWidget {
  const SecondTemplateContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 136.w,
      height: 160.h,
      decoration: const BoxDecoration(
        color: Color(0xFF8F01DF),
        shape: BoxShape.circle,
      ),
    );
  }
}
