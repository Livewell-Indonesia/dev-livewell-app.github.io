import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart' as vg;
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:livewell/core/helper/tracker/livewell_tracker.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/diary/presentation/page/user_diary_screen.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/feature/streak/presentation/widget/streak_item.dart';
import 'package:livewell/feature/water/data/model/water_list_model.dart';
import 'package:livewell/feature/water/presentation/controller/water_controller.dart';
import 'package:livewell/feature/water/presentation/enum/water_shortcut_type.dart';
import 'package:livewell/feature/water/presentation/pages/water_custom_input_page.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/theme/design_system.dart';
import 'package:livewell/widgets/floating_dots/floating_dots.dart';
import 'package:collection/collection.dart';
import 'package:livewell/widgets/popup_asset/popup_asset_widget.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';

class WaterScreen extends StatefulWidget {
  const WaterScreen({super.key});

  @override
  State<WaterScreen> createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen> {
  final WaterController controller = Get.put(WaterController());

  @override
  void initState() {
    controller.trackEvent(LivewellWaterEvent.waterPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      trailing: InkWell(
        onTap: () {
          HomeController controller = Get.find();
          var data = controller.popupAssetsModel.value.exercise;
          controller.trackEvent(LivewellSleepEvent.sleepPageInformationButton);
          if (data != null) {
            showModalBottomSheet<dynamic>(
                context: context,
                isScrollControlled: true,
                shape: ShapeBorder.lerp(const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                    const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))), 1),
                builder: (context) {
                  return Obx(() {
                    return PopupAssetWidget(
                      exercise: controller.popupAssetsModel.value.water!,
                    );
                  });
                });
          }
        },
        child: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: const Icon(
            Icons.info_outline,
            color: Color(0xFF171433),
          ),
        ),
      ),
      body: Expanded(
        child: ListView(
          children: [
            Obx(() {
              return WaterAnimationWidget(
                value: Get.find<DashboardController>().waterConsumed.value.toInt(),
                maxValue: ((int.parse((Get.find<DashboardController>().user.value.onboardingQuestionnaire?.glassesOfWaterDaily ?? "0")) * 0.25) * 1000).toInt(),
              );
            }),
            12.verticalSpace,
            Center(child: Obx(() {
              return Text(
                ((int.parse((Get.find<DashboardController>().user.value.onboardingQuestionnaire?.glassesOfWaterDaily ?? "0")) * 0.25) * 1000).toInt() -
                            Get.find<DashboardController>().waterConsumed.value.toInt() >
                        0
                    ? '${controller.localization.hydrationRemaining ?? 'Remaining'} ${((int.parse((Get.find<DashboardController>().user.value.onboardingQuestionnaire?.glassesOfWaterDaily ?? "0")) * 0.25) * 1000).toInt() - Get.find<DashboardController>().waterConsumed.value.toInt()} ml'
                    : controller.localization.hydrationYouHitYourGoalToday ?? 'You hit your goal today!',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14.sp),
              );
            })),
            16.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: WaterShortcutType.values.map((e) {
                  return InkWell(
                      onTap: () {
                        if (e == WaterShortcutType.custom) {
                          AppNavigator.push(routeName: AppPages.waterCustomInput, arguments: {"waterInputType": WaterInputType.increase});
                        } else {
                          controller.addWater(e.value);
                        }
                      },
                      child: WaterShortcutButton(type: e));
                }).toList(),
              ),
            ),
            16.verticalSpace,
            ReduceWaterSection(
              onTap: () {
                AppNavigator.push(routeName: AppPages.waterCustomInput, arguments: {"waterInputType": WaterInputType.reduce});
              },
            ),
            16.verticalSpace,
            Obx(() {
              return HydartionScoreWidget(
                score: Get.find<DashboardController>().wellnessData.value?.hydrationScore ?? 0,
              );
            }),
            16.verticalSpace,
            const UrineColorWidget(),
            // 40.verticalSpace,
            // Obx(() {
            //   return RichText(
            //       textAlign: TextAlign.center,
            //       text: TextSpan(children: [
            //         TextSpan(text: controller.localization.yourWaterIntakeForToday!, style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w600, color: const Color(0xFF171433))),
            //         TextSpan(text: controller.waterConsumed.value.toStringAsFixed(1), style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w600, color: const Color(0xFF8F01DF))),
            //       ]));
            // }),
            // 32.verticalSpace,
            // Obx(() {
            //   return DrinkIndicator(
            //     value: controller.waterConsumedPercentage.value,
            //     label: controller.waterConsumed.value.toStringAsFixed(1),
            //   );
            // }),
            // Obx(() {
            //   return Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16),
            //     child: WaterRuler(
            //       value: controller.waterConsumedPercentage.value,
            //     ),
            //   );
            // }),
            // 32.verticalSpace,
            // // Obx(() {
            // //   return WaterHistoriesWidget(
            // //     waterHistories: contoller.waterList.value,
            // //   );
            // // }),
            // // Container(
            // //   margin: const EdgeInsets.symmetric(horizontal: 16),
            // //   padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
            // //   decoration: BoxDecoration(
            // //     color: Colors.white,
            // //     borderRadius: BorderRadius.circular(30),
            // //   ),
            // //   child: Column(
            // //     crossAxisAlignment: CrossAxisAlignment.start,
            // //     children: [
            // //       const Padding(
            // //         padding: EdgeInsets.only(bottom: 18.0),
            // //         child: Text("Last Update",
            // //             style: TextStyle(
            // //                 fontSize: 16,
            // //                 fontWeight: FontWeight.w700,
            // //                 color: Color(0xFF171433))),
            // //       ),
            // //       ListView.separated(
            // //           physics: const NeverScrollableScrollPhysics(),
            // //           shrinkWrap: true,
            // //           itemCount: 2,
            // //           itemBuilder: (context, index) {
            // //             return Row(
            // //               children: [
            // //                 Text('Water',
            // //                     style: TextStyle(
            // //                       fontSize: 16.sp,
            // //                       fontWeight: FontWeight.w500,
            // //                       color: const Color(0xFF171433),
            // //                     )),
            // //                 const Spacer(),
            // //                 Text('50 ml',
            // //                     style: TextStyle(
            // //                         fontSize: 16.sp,
            // //                         color: const Color(0xFF171433),
            // //                         fontWeight: FontWeight.w500)),
            // //               ],
            // //             );
            // //           },
            // //           separatorBuilder: (context, index) {
            // //             return const Padding(
            // //               padding: EdgeInsets.symmetric(vertical: 8.0),
            // //               child: Divider(),
            // //             );
            // //           }),
            // //     ],
            // //   ),
            // // ),
            // 40.verticalSpace,
            // LiveWellButton(
            //     label: controller.localization.addDrink!,
            //     color: const Color(0xFF8F01DF),
            //     textColor: const Color(0xFFFFFFFF),
            //     onPressed: () {
            //       controller.trackEvent(LivewellWaterEvent.waterPageAddDrinkButton);
            //       AppNavigator.push(routeName: AppPages.waterConsumedPage, arguments: {"waterInputType": WaterInputType.increase});
            //     }),
            // 20.verticalSpace,
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16.w),
            //   child: OutlinedButton(
            //       style: OutlinedButton.styleFrom(
            //         padding: EdgeInsets.symmetric(vertical: 16.h),
            //         side: const BorderSide(width: 2, color: Color(0xFF8F01DF)),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(30.r),
            //         ),
            //       ),
            //       onPressed: () {
            //         controller.trackEvent(LivewellWaterEvent.waterPageReduceWaterButton);
            //         AppNavigator.push(routeName: AppPages.waterConsumedPage, arguments: {"waterInputType": WaterInputType.reduce});
            //       },
            //       child: Text(
            //         'Reduce Water',
            //         style: TextStyle(color: const Color(0xFF171433), fontSize: 16.sp, fontWeight: FontWeight.w500),
            //       )),
            // ),
          ],
        ),
      ),
      title: controller.localization.hydrationTitle ?? 'Hydration',
    );
  }
}

class HydartionScoreWidget extends StatelessWidget {
  final int score;
  HydartionScoreWidget({super.key, required this.score});
  final WaterController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: score == 0 ? emptyState(context) : hydrationScore(context),
    );
  }

  Widget emptyState(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset('assets/icons/ic_hydration_score.svg', width: 64.w, height: 64.h),
        16.verticalSpace,
        Text('Your Hydration Score is still empty!', style: TextStyle(color: Theme.of(context).colorScheme.neutral100, fontWeight: FontWeight.w600, fontSize: 14.sp)),
        8.verticalSpace,
        Text('Let\'s help your body stay hydrated and track your hydration progress by logging your glasses of water today!',
            textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).colorScheme.neutral90, fontWeight: FontWeight.w400, fontSize: 12.sp)),
      ],
    );
  }

  String scoreToDescription(int score) {
    var details = controller.wellnessCalculationModel.details.where((element) => element.type == StreakItemType.hydration).first;
    var description = details.descriptions.firstWhere((element) {
      return score == int.parse(element.score);
    });
    return description.description;
  }

  Widget hydrationScore(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset('assets/icons/ic_hydration_score.svg', width: 36.w, height: 36.h),
            8.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(controller.localization.hydrationHydrationScoreToday ?? 'Hydration Score Today',
                    style: TextStyle(color: Theme.of(context).colorScheme.neutral70, fontWeight: FontWeight.w400, fontSize: 12.sp)),
                Obx(() {
                  return Text(scoreToDescription(Get.find<DashboardController>().wellnessData.value?.hydrationScore ?? 0),
                      style: TextStyle(color: Theme.of(context).colorScheme.neutral100, fontWeight: FontWeight.w600, fontSize: 16.sp));
                })
              ],
            ),
          ],
        ),
        16.verticalSpace,
        Text('You\'re doing well in staying hydrated! Keep it up by drinking water regularly to maintain optimal health.',
            style: TextStyle(color: Theme.of(context).colorScheme.neutral90, fontWeight: FontWeight.w500, fontSize: 12.sp)),
        16.verticalSpace,
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: controller.localization.hydrationSeeHowDoHydrationScoreCalculated ?? 'See how do Hydration Score calculated ',
                style: TextStyle(color: Theme.of(context).colorScheme.disabled, fontSize: 12.sp, fontWeight: FontWeight.w400),
              ),
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    showModalBottomSheet(
                        context: context,
                        shape: shapeBorder(),
                        isScrollControlled: true,
                        builder: (context) {
                          return Wrap(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(32),
                                    topRight: Radius.circular(32),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'How do Hydration Score calculated?',
                                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutral100),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: controller.wellnessCalculationModel.details.where((element) => element.type == StreakItemType.hydration).map((e) {
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              16.verticalSpace,
                                              Text(
                                                e.title,
                                                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutral100),
                                              ),
                                              8.verticalSpace,
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Theme.of(context).colorScheme.neutral30,
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      color: Theme.of(context).colorScheme.neutral20,
                                                      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 5,
                                                            child: Text(
                                                              'Ranges',
                                                              style: TextStyle(color: Theme.of(context).colorScheme.black600, fontWeight: FontWeight.w600, fontSize: 14.sp),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                              'Score',
                                                              style: TextStyle(color: Theme.of(context).colorScheme.black600, fontWeight: FontWeight.w600, fontSize: 14.sp),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 5,
                                                            child: Text(
                                                              'Category',
                                                              style: TextStyle(color: Theme.of(context).colorScheme.black600, fontWeight: FontWeight.w600, fontSize: 14.sp),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    ListView.separated(
                                                      shrinkWrap: true,
                                                      physics: const NeverScrollableScrollPhysics(),
                                                      itemBuilder: (context, index) {
                                                        return Container(
                                                          color: index % 2 == 0 ? Colors.transparent : Theme.of(context).colorScheme.neutral20,
                                                          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                flex: 5,
                                                                child: Text(
                                                                  e.descriptions[index].range,
                                                                  style: TextStyle(color: Theme.of(context).colorScheme.black600, fontSize: 14.sp),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 2,
                                                                child: Text(
                                                                  e.descriptions[index].score,
                                                                  style: TextStyle(color: Theme.of(context).colorScheme.black600, fontSize: 14.sp),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 5,
                                                                child: Text(
                                                                  e.descriptions[index].description,
                                                                  style: TextStyle(color: Theme.of(context).colorScheme.black600, fontSize: 14.sp),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                      separatorBuilder: (context, index) {
                                                        return const SizedBox();
                                                      },
                                                      itemCount: e.descriptions.length,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                text: controller.localization.hydrationHere ?? 'here',
                style: TextStyle(color: Theme.of(context).colorScheme.primaryPurple, fontSize: 12.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class UrineColorWidget extends StatefulWidget {
  const UrineColorWidget({super.key});

  @override
  State<UrineColorWidget> createState() => _UrineColorWidgetState();
}

class _UrineColorWidgetState extends State<UrineColorWidget> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      height: isExpanded ? 380.h : 92.h,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Get.find<DashboardController>().localization.hydrationLearnYourUrineColor ?? 'Learn Your urine color',
                        style: TextStyle(color: Theme.of(context).colorScheme.neutral100, fontWeight: FontWeight.w600, fontSize: 14.sp),
                      ),
                      4.verticalSpace,
                      Text(
                        Get.find<DashboardController>().localization.hydrationUnderstandYourHydration ?? 'Understand your hydration levels and maintain optimal health by learning your urine color.',
                        style: TextStyle(color: Theme.of(context).colorScheme.neutral90, fontWeight: FontWeight.w400, fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: Theme.of(context).colorScheme.neutral100,
                    size: 24.sp,
                  ),
                ),
              ],
            ),
          ),
          isExpanded
              ? ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 16.h),
                  itemBuilder: (context, index) {
                    return UrineItem(types: UrineData.urineColors[index]);
                  },
                  separatorBuilder: (context, index) {
                    return 16.verticalSpace;
                  },
                  itemCount: UrineData.urineColors.length)
              : const SizedBox()
        ],
      ),
    );
  }
}

class UrineItem extends StatelessWidget {
  final List<UrineColorType> types;
  UrineItem({super.key, required this.types});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          key: key,
          flex: 6,
          child: UrineItemWidget(types: types),
        ),
        Expanded(
            flex: 4,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 12.w),
                  height: types.length * 44.h,
                  width: 16.w,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border(
                        right: BorderSide(color: Theme.of(context).colorScheme.neutral60),
                        top: BorderSide(color: Theme.of(context).colorScheme.neutral60),
                        bottom: BorderSide(color: Theme.of(context).colorScheme.neutral60),
                      )),
                ),
                13.horizontalSpace,
                Expanded(
                  child: Text(
                    types.first.description,
                    style: TextStyle(color: Theme.of(context).colorScheme.neutral80, fontWeight: FontWeight.w600, fontSize: 12.sp),
                  ),
                ),
              ],
            ))
      ],
    );
  }
}

class UrineItemWidget extends StatelessWidget {
  const UrineItemWidget({
    super.key,
    required this.types,
  });

  final List<UrineColorType> types;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(types[index].title, style: TextStyle(color: Theme.of(context).colorScheme.neutral80, fontWeight: FontWeight.w600, fontSize: 12.sp)),
                      4.verticalSpace,
                      Text(types[index].colorName, style: TextStyle(color: Theme.of(context).colorScheme.neutral80, fontWeight: FontWeight.w400, fontSize: 12.sp)),
                    ],
                  ),
                  18.horizontalSpace,
                  Container(
                    width: 48.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                      color: types[index].color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) {
              return 16.verticalSpace;
            },
            itemCount: types.length)
      ],
    );
  }
}

class ReduceWaterSection extends StatelessWidget {
  final VoidCallback onTap;
  const ReduceWaterSection({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(Get.find<DashboardController>().localization.hydrationWantToReduceWaterIntake ?? 'Want to reduce your water intake?',
            style: TextStyle(color: Theme.of(context).colorScheme.neutral80, fontWeight: FontWeight.w600, fontSize: 12.sp)),
        12.horizontalSpace,
        InkWell(
          onTap: onTap,
          child: Row(
            children: [
              Icon(Icons.remove_circle_outline, color: Theme.of(context).colorScheme.primaryPurple, size: 14.sp),
              4.horizontalSpace,
              Text(Get.find<DashboardController>().localization.hydrationReduce ?? 'Reduce Water',
                  style: TextStyle(color: Theme.of(context).colorScheme.primaryPurple, fontWeight: FontWeight.w600, fontSize: 12.sp)),
            ],
          ),
        ),
      ],
    );
  }
}

class WaterShortcutButton extends StatelessWidget {
  final WaterShortcutType type;
  const WaterShortcutButton({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          vg.SvgPicture.asset(
            type.assets,
            width: 36.w,
            height: 36.h,
          ),
          4.verticalSpace,
          Text(
            type.title,
            style: TextStyle(fontSize: 14.sp, color: Theme.of(context).colorScheme.neutral90, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class WaterHistoriesWidget extends StatelessWidget {
  final List<WaterModel> waterHistories;
  const WaterHistoriesWidget({super.key, required this.waterHistories});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: CarouselSlider(
        options: CarouselOptions(
          enableInfiniteScroll: false,
          viewportFraction: 1.0,
        ),
        items: waterHistories.slices(3).map((e) {
          return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: e.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Text(e[index].createdAt ?? "",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF171433),
                        )),
                    const Spacer(),
                    Text('50 ml', style: TextStyle(fontSize: 16.sp, color: const Color(0xFF171433), fontWeight: FontWeight.w500)),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(),
                );
              });
        }).toList(),
      ),
    );
  }
}

class DrinkIndicator extends StatefulWidget {
  final double value;
  final String label;
  const DrinkIndicator({super.key, required this.value, required this.label});

  @override
  State<DrinkIndicator> createState() => _DrinkIndicatorState();
}

class _DrinkIndicatorState extends State<DrinkIndicator> {
  double widthValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.value == 0.0
            ? Container()
            : Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                    width: widget.value == 0 ? 0.0 : (((1.sw - 56) * widget.value) - 25 - 8).minZero,
                  ),
                  Container(
                    width: 50,
                    height: 50.h,
                    margin: EdgeInsets.only(right: widget.value == 0 ? 28 : 0, left: widget.value == 0 ? 0 : 28),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [vg.SvgPicture.asset("assets/icons/buble.svg"), Text(widget.label, style: TextStyle(fontSize: 20.sp, color: Colors.white, fontWeight: FontWeight.w600))],
                    ),
                  ),
                ],
              ),
        Container(
          width: 1.sw,
          height: 72.h,
          margin: const EdgeInsets.symmetric(horizontal: 28),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: LayoutBuilder(
              builder: (context, containerConstraint) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 1000),
                  height: 72.h,
                  width: containerConstraint.maxWidth * widget.value,
                  curve: Curves.fastOutSlowIn,
                  margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xFF34EAB2),
                  ),
                  child: FloatingDotGroup(
                    number: 50,
                    direction: Direction.up,
                    trajectory: Trajectory.random,
                    size: DotSize.small,
                    colors: [Colors.white.withOpacity(0.7), Colors.white.withOpacity(0.5), Colors.white.withOpacity(0.3)],
                    opacity: 0.5,
                    speed: DotSpeed.fast,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

extension on double {
  double get minZero => this < 0 ? 0 : this;
}

class WaterRuler extends StatelessWidget {
  final double value;
  const WaterRuler({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(50, (index) {
            return SizedBox(
              height: ((index % 5 == 0) && index != 0) ? 32 : 16,
              child: VerticalDivider(
                width: 1,
                thickness: 2,
                color: (index <= value * 50) ? const Color(0xFF34EAB2) : const Color(0xFF34EAB2),
              ),
            );
          }).toList(),
        ),
        8.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: WaterRatings.values.map((e) => Text(e.value, style: TextStyle(fontSize: 16.sp, color: const Color(0xFF171433), fontWeight: FontWeight.w500))).toList(),
        ),
      ],
    );
  }
}

enum WaterRatings { poor, good, almost, perfect }

extension on WaterRatings {
  String get value {
    switch (this) {
      case WaterRatings.poor:
        return Get.find<HomeController>().localization.poor!;
      case WaterRatings.good:
        return Get.find<HomeController>().localization.good!;
      case WaterRatings.almost:
        return Get.find<HomeController>().localization.almost!;
      case WaterRatings.perfect:
        return Get.find<HomeController>().localization.great!;
    }
  }
}

class WaterAnimationWidget extends StatefulWidget {
  final int value;
  final int maxValue;
  const WaterAnimationWidget({super.key, required this.value, required this.maxValue});

  @override
  State<WaterAnimationWidget> createState() => _WaterAnimationWidgetState();
}

class _WaterAnimationWidgetState extends State<WaterAnimationWidget> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: SizedBox(
            height: 184.h,
            width: 184.w,
            child: LiquidCircularProgressIndicator(
              valueColor: const AlwaysStoppedAnimation(
                Color(0xFF34EAB2),
              ),
              value: widget.value == 0
                  ? -1
                  : widget.value >= widget.maxValue
                      ? 1.1
                      : widget.value / widget.maxValue,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${widget.value} ml',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24.sp),
                  ),
                  Text(
                    '/ ${widget.maxValue} ml',
                    style: TextStyle(color: Color(0xFF505050), fontWeight: FontWeight.w400, fontSize: 14.sp),
                  ),
                ],
              ),
            ),
          ),
        ),
        // LiquidCustomProgressIndicator(direction: Axis.vertical,
        //         value: 1.1,
        //         valueColor: const AlwaysStoppedAnimation(Color(0xFF34EAB2)),shapePath: parseSvgPath("M120.799 3.08191e-05H138.199C147.22 -0.00446338 155.96 3.13678 162.907 8.88089C169.854 14.625 174.572 22.611 176.246 31.4586C177.92 40.3063 176.444 49.4595 172.074 57.3364C167.703 65.2133 179.798 64.5 182.311 74.5977C185.433 87.138 194.618 96.6398 208.679 110.468L208.937 110.725C218.844 120.459 230.583 131.995 240.851 147.367C241.109 147.711 241.324 148.071 241.496 148.449C253.903 167.681 259.782 190.386 258.266 213.21C258.421 215.098 258.498 216.987 258.498 218.875V347.625C258.498 358.925 255.517 370.026 249.856 379.812C244.195 389.598 236.053 397.724 226.248 403.374C216.443 409.024 205.32 411.998 193.998 411.998C182.676 411.998 171.554 409.024 161.749 403.374C151.944 409.024 140.821 412 129.499 412C118.177 412 107.054 409.024 97.2493 403.374C87.4443 409.024 76.3219 411.998 65 411.998C53.6781 411.998 42.5556 409.024 32.7505 403.374C22.9454 397.724 14.8031 389.598 9.14192 379.812C3.48079 370.026 0.500288 358.925 0.5 347.625V218.875C0.5 216.987 0.586012 215.098 0.758011 213.21C0.587679 210.81 0.501614 208.406 0.5 206C0.5 171.753 16.9861 141.316 42.5537 120.355C45.4777 117.266 48.2985 114.33 51.0161 111.549L51.0676 111.523C64.8189 97.3608 73.7973 87.7045 76.7901 74.6493C79.0021 65 91.341 65.3017 86.9432 57.4231C82.5455 49.5446 81.0487 40.3785 82.7123 31.5139C84.3759 22.6494 89.095 14.6454 96.0515 8.88943C103.008 3.13351 111.763 -0.0113571 120.799 3.08191e-05Z"))
        // Center(
        //   child: Container(
        //     width: 184.w,
        //     height: 184.h,
        //     decoration: BoxDecoration(
        //       color: const Color(0xFF34EAB2),
        //       shape: BoxShape.circle,
        //     ),
        //   ),
        // ),
        // Center(
        //   child: Container(
        //      width: 184.w,
        //     height: 184.h,
        //     decoration: BoxDecoration(
        //       color: const Color(0xFF34EAB2),
        //       shape: BoxShape.circle,
        //     ),
        //     child: CustomPaint(
        //       painter: MyPainter(
        //         firstAnimation.value,
        //         secondAnimation.value,
        //         thirdAnimation.value,
        //         fourthAnimation.value,
        //       ),
        //     ),
        //   ),
        // )
        // Center(
        //   child: Text('50 %', style: TextStyle(fontWeight: FontWeight.w600, wordSpacing: 3, color: Colors.white.withOpacity(.7)
        //   ,
        //   )
        //   ,
        //   ),
        // ),
        //       Container(
        //   width: 184.w,
        //         height: 184.h,
        //   child: ClipRRect(
        //     clipBehavior: Clip.antiAliasWithSaveLayer,
        //     child: Stack(
        //       clipBehavior: Clip.none,
        //       children: [
        //         CustomPaint(
        //           painter: MyPainter(
        //             firstAnimation.value,
        //             secondAnimation.value,
        //             thirdAnimation.value,
        //             fourthAnimation.value,
        //           ),
        //           child:  Container(
        //             width: 184.w,
        //             height: 184.h,
        //             decoration: const BoxDecoration(
        //               color:  Color(0xFF34EAB2),
        //               shape: BoxShape.circle,
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..strokeWidth = 2;
    var max = 35;
    var dashWidth = 5;
    var dashSpace = 5;
    double startY = 0;
    while (max >= 0) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
      final space = (dashSpace + dashWidth);
      startY += space;
      max -= space;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
