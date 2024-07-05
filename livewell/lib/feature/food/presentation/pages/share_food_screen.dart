import 'dart:io';

import 'package:appinio_social_share/appinio_social_share.dart';
import 'package:davinci/core/davinci_capture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/core/helper/tracker/livewell_tracker.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/exercise/presentation/pages/exercise_share_page.dart';
import 'package:livewell/feature/food/data/model/foods_model.dart';
import 'package:livewell/feature/food/presentation/pages/choose_template_share_food.dart';
import 'package:livewell/routes/app_navigator.dart';
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
              Get.find<DashboardController>().trackEvent(LivewellFoodEvent.detailPageShareBackButton);
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
                  servings: "${food?.servings?.first.servingDescription ?? ""} ${food?.servings?.first.servingDesc ?? ""}",
                  calories: "${food?.servings?[0].calories ?? ""} cal",
                  fat: "${food?.servings?[0].fat ?? ""} g",
                  carbs: "${food?.servings?[0].carbohydrate ?? ""} g",
                  protein: "${food?.servings?[0].protein ?? ""} g",
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
                            calories: food?.servings?[0].calories ?? "" " cal",
                            fat: food?.servings?[0].fat ?? "" "g",
                            carbs: food?.servings?[0].carbohydrate ?? "" " g",
                            protein: food?.servings?[0].protein ?? "" " g",
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
                            Get.find<DashboardController>().trackEvent(LivewellFoodEvent.detailPageShareShareToInstagramButton);
                            await AppinioSocialShare().shareToInstagramStory("108487895683370", backgroundImage: files.path);
                            AppNavigator.popUntil(routeName: AppPages.addFood);
                          case ShareButtonType.facebook:
                            Get.find<DashboardController>().trackEvent(LivewellFoodEvent.detailPageShareShareToFacebookButton);
                            await AppinioSocialShare().shareToFacebookStory("108487895683370", backgroundImage: files.path);
                            AppNavigator.popUntil(routeName: AppPages.addFood);
                          default:
                            Get.find<DashboardController>().trackEvent(LivewellFoodEvent.detailPageShareSaveImageButton);
                            await AppinioSocialShare().shareToSystem("food", "", filePath: files.path);
                            AppNavigator.popUntil(routeName: AppPages.addFood);
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
            left: type == TemplateType.second ? -45.w : null,
            child: type == TemplateType.first
                ? FirstTemplateContent(
                    foodName: foodName,
                    servings: servings,
                    calories: calories,
                    fat: fat,
                    protein: protein,
                    carbs: carbs,
                  )
                : SecondTemplateContent(
                    foodName: foodName,
                    servings: servings,
                    calories: calories,
                    fat: fat,
                    protein: protein,
                    carbs: carbs,
                  ),
          ),
        ],
      ),
    );
  }
}

class FirstTemplateContent extends StatelessWidget {
  final String foodName;
  final String servings;
  final String calories;
  final String fat;
  final String carbs;
  final String protein;
  final double? containerWidth;
  const FirstTemplateContent({super.key, required this.foodName, required this.servings, required this.calories, required this.fat, required this.carbs, required this.protein, this.containerWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //color: const Color(0xFFDDF235),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16.r),
          bottomRight: Radius.circular(16.r),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.horizontalSpace,
          Column(
            children: [
              SizedBox(
                width: 30.w,
                height: 30.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.r),
                  child: Image.asset(Constant.icLivewellYellow),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 2.w,
                    height: 150.h,
                    color: const Color(0xFF8F01DF),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  width: containerWidth ?? 0.6.sw,
                  child: Text(
                    foodName,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(color: const Color(0xFFDDF235), fontSize: 16.sp, fontWeight: FontWeight.w600, shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ]),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  servings,
                  style: TextStyle(color: const Color(0xFFDDF235), fontSize: 10.sp, fontWeight: FontWeight.w600, shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ]),
                ),
              ),
              20.verticalSpace,
              Text('Carbs',
                  style: TextStyle(color: const Color(0xFFDDF235), fontSize: 14.sp, fontWeight: FontWeight.w600, shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ])),
              Text(carbs,
                  style: TextStyle(color: const Color(0xFFDDF235), fontSize: 8.sp, fontWeight: FontWeight.w600, shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ])),
              8.verticalSpace,
              Text('Protein',
                  style: TextStyle(color: const Color(0xFFDDF235), fontSize: 14.sp, fontWeight: FontWeight.w600, shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ])),
              Text(protein,
                  style: TextStyle(color: const Color(0xFFDDF235), fontSize: 8.sp, fontWeight: FontWeight.w600, shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ])),
              8.verticalSpace,
              Text('Fat',
                  style: TextStyle(color: const Color(0xFFDDF235), fontSize: 14.sp, fontWeight: FontWeight.w600, shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ])),
              Text(fat,
                  style: TextStyle(color: const Color(0xFFDDF235), fontSize: 8.sp, fontWeight: FontWeight.w600, shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ])),
              8.verticalSpace,
              Text('Kcal',
                  style: TextStyle(color: const Color(0xFFDDF235), fontSize: 14.sp, fontWeight: FontWeight.w600, shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ])),
              Text(calories,
                  style: TextStyle(color: const Color(0xFFDDF235), fontSize: 8.sp, fontWeight: FontWeight.w600, shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ])),
            ],
          ),
        ],
      ),
    );
  }
}

class SecondTemplateContent extends StatelessWidget {
  final String foodName;
  final String servings;
  final String calories;
  final String fat;
  final String carbs;
  final String protein;
  const SecondTemplateContent({super.key, required this.foodName, required this.servings, required this.calories, required this.fat, required this.carbs, required this.protein});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 190.w,
        height: 200.h,
        decoration: const BoxDecoration(
          color: Color(0xFF8F01DF),
          shape: BoxShape.circle,
        ),
        child: ClipRRect(
          //borderRadius: BorderRadius.circular(300),
          child: Padding(
            padding: const EdgeInsets.only(left: 60, top: 30, right: 20, bottom: 20),
            child: ClipRRect(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    Constant.livewellLogoYellowSVG,
                    width: 60.w,
                    color: const Color(0xFFDDF235),
                    alignment: Alignment.bottomCenter,
                  ),
                  4.verticalSpace,
                  Container(
                    width: 60.w,
                    height: 1.h,
                    color: const Color(0xFFDDF235),
                  ),
                  4.verticalSpace,
                  Text(
                    foodName,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(color: const Color(0xFFDDF235), fontSize: 16.sp, fontWeight: FontWeight.w600, shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ]),
                  ),
                  2.verticalSpace,
                  Text(
                    servings,
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: const Color(0xFFDDF235), fontSize: 12.sp, fontWeight: FontWeight.w600, shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ]),
                  ),
                  12.verticalSpace,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          "Carbs",
                          textAlign: TextAlign.start,
                          style: TextStyle(color: const Color(0xFFDDF235), fontSize: 10.sp, fontWeight: FontWeight.w600, shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ]),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          carbs,
                          textAlign: TextAlign.start,
                          style: TextStyle(color: const Color(0xFFDDF235), fontSize: 10.sp, fontWeight: FontWeight.w600, shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ]),
                        ),
                      ),
                      const Spacer(
                        flex: 4,
                      )
                    ],
                  ),
                  4.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          "Fat",
                          textAlign: TextAlign.start,
                          style: TextStyle(color: const Color(0xFFDDF235), fontSize: 10.sp, fontWeight: FontWeight.w600, shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ]),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          fat,
                          textAlign: TextAlign.start,
                          style: TextStyle(color: const Color(0xFFDDF235), fontSize: 10.sp, fontWeight: FontWeight.w600, shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ]),
                        ),
                      ),
                      const Spacer(
                        flex: 4,
                      ),
                    ],
                  ),
                  4.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          "Protein",
                          textAlign: TextAlign.start,
                          style: TextStyle(color: const Color(0xFFDDF235), fontSize: 10.sp, fontWeight: FontWeight.w600, shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ]),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          protein,
                          textAlign: TextAlign.start,
                          style: TextStyle(color: const Color(0xFFDDF235), fontSize: 10.sp, fontWeight: FontWeight.w600, shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ]),
                        ),
                      ),
                      const Spacer(
                        flex: 4,
                      )
                    ],
                  ),
                  4.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          "Kcal",
                          textAlign: TextAlign.start,
                          style: TextStyle(color: const Color(0xFFDDF235), fontSize: 10.sp, fontWeight: FontWeight.w600, shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ]),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          calories,
                          textAlign: TextAlign.start,
                          style: TextStyle(color: const Color(0xFFDDF235), fontSize: 10.sp, fontWeight: FontWeight.w600, shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ]),
                        ),
                      ),
                      const Spacer(
                        flex: 4,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
