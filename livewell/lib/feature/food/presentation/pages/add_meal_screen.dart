import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/feature/food/data/model/foods_model.dart';
import 'package:livewell/feature/food/presentation/controller/add_meal_controller.dart';
import 'package:livewell/feature/food/presentation/pages/add_food_screen.dart';
import 'package:livewell/feature/food/presentation/pages/food_screen.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';
import 'dart:developer';

import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({Key? key}) : super(key: key);

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen>
    with TickerProviderStateMixin {
  final AddMealController addMealController = Get.put(AddMealController());
  String? type;
  DateTime? date;

  @override
  void initState() {
    type = Get.arguments['type'];
    date = Get.arguments['date'];
    createTutorial();
    Future.delayed(const Duration(milliseconds: 800), () {
      addMealController.showTutorial(context);
    });
    super.initState();
  }

  createTutorial() {
    addMealController.tutorialCoachMark = TutorialCoachMark(
        targets: createTargets(),
        colorShadow: Colors.black,
        textSkip: "SKIP",
        pulseEnable: false,
        paddingFocus: 0,
        opacityShadow: 0.7,
        alignSkip: Alignment.topRight,
        focusAnimationDuration: const Duration(milliseconds: 300),
        unFocusAnimationDuration: const Duration(milliseconds: 300),
        onFinish: () {
          addMealController.onFinishCoachmark();
        },
        onSkip: () {
          addMealController.onFinishCoachmark();
        },
        onClickTarget: (p0) {
          addMealController.tutorialCoachMark.next();
        },
        onClickTargetWithTapPosition: ((p0, p1) {}));
  }

  List<TargetFocus> createTargets() {
    List<TargetFocus> targets = [];
    targets.add(
      TargetFocus(
        identify: 'Target 1',
        keyTarget: addMealController.key1,
        shape: ShapeLightFocus.RRect,
        radius: 20,
        color: Colors.black,
        contents: [
          TargetContent(
              align: ContentAlign.bottom,
              builder: (context, controller) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Search Bar".tr,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 16.sp),
                      ),
                      4.verticalSpace,
                      Text(
                        'Use the search bar to find nutritional details for your foods, brands, and franchises. If a specific brand is unavailable, simply add the word \'generic\' to find typical nutritional values for your desired food.',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF808080),
                            height: 1.3,
                            fontSize: 14.sp),
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          const CoachmarkIndicator(position: 0),
                          const Spacer(),
                          InkWell(
                              onTap: () {
                                addMealController.tutorialCoachMark.next();
                              },
                              child: Text(
                                'Next',
                                style: TextStyle(
                                    color: const Color(0xFF8F01DF),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600),
                              ))
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: 'Target 2',
        keyTarget: addMealController.key2,
        shape: ShapeLightFocus.RRect,
        radius: 24,
        color: Colors.black,
        contents: [
          TargetContent(
              align: ContentAlign.bottom,
              builder: (context, controller) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Food Recommendation".tr,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 16.sp),
                      ),
                      4.verticalSpace,
                      Text(
                        'Discover personalized food recommendations that match your nutritional needs. Filter franchise restaurants with ease and enjoy your meals to the fullest!',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF808080),
                            height: 1.3,
                            fontSize: 14.sp),
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          const CoachmarkIndicator(position: 1),
                          const Spacer(),
                          InkWell(
                              onTap: () {
                                addMealController.tutorialCoachMark.previous();
                              },
                              child: Text(
                                'Prev',
                                style: TextStyle(
                                    color: const Color(0xFF808080),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600),
                              )),
                          24.horizontalSpace,
                          InkWell(
                              onTap: () {
                                addMealController.tutorialCoachMark.next();
                              },
                              child: Text(
                                'Next',
                                style: TextStyle(
                                    color: const Color(0xFF8F01DF),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600),
                              ))
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: 'Target 3',
        keyTarget: addMealController.key3,
        shape: ShapeLightFocus.RRect,
        radius: 10,
        color: Colors.black,
        contents: [
          TargetContent(
              align: ContentAlign.bottom,
              builder: (context, controller) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Request New Food".tr,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 16.sp),
                      ),
                      4.verticalSpace,
                      Text(
                        'Found a food that is not listed in our database? Simply request for it to be added by clicking on the \'Add Food\' button. We are always updating our database to make it better for you.',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF808080),
                            height: 1.3,
                            fontSize: 14.sp),
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          const CoachmarkIndicator(position: 2),
                          const Spacer(),
                          InkWell(
                              onTap: () {
                                addMealController.tutorialCoachMark.previous();
                              },
                              child: Text(
                                'Prev',
                                style: TextStyle(
                                    color: const Color(0xFF808080),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600),
                              )),
                          24.horizontalSpace,
                          InkWell(
                              onTap: () {
                                addMealController.tutorialCoachMark.next();
                              },
                              child: Text(
                                'Next',
                                style: TextStyle(
                                    color: const Color(0xFF8F01DF),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600),
                              ))
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: 'Target 4',
        keyTarget: addMealController.key4,
        shape: ShapeLightFocus.Circle,
        color: Colors.black,
        contents: [
          TargetContent(
              align: ContentAlign.bottom,
              builder: (context, controller) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Food Filter".tr,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 16.sp),
                      ),
                      4.verticalSpace,
                      Text(
                        'Filter restaurant/brands by calories, protein, carbs, and fat.',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF808080),
                            height: 1.3,
                            fontSize: 14.sp),
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          const CoachmarkIndicator(position: 3),
                          const Spacer(),
                          InkWell(
                              onTap: () {
                                addMealController.tutorialCoachMark.previous();
                              },
                              child: Text(
                                'Prev',
                                style: TextStyle(
                                    color: const Color(0xFF808080),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600),
                              )),
                          24.horizontalSpace,
                          InkWell(
                              onTap: () {
                                addMealController.tutorialCoachMark.finish();
                              },
                              child: Text(
                                'Done',
                                style: TextStyle(
                                    color: const Color(0xFF8F01DF),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600),
                              ))
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
    return targets;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (addMealController.tutorialCoachMark.isShowing) {
          addMealController.tutorialCoachMark.finish();
          addMealController.onFinishCoachmark();
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: LiveWellScaffold(
        title: MealTime.values
            .byName((type ?? MealTime.breakfast.name).toLowerCase())
            .appBarTitle(),
        body: Expanded(
          child: Column(
            children: [
              24.verticalSpace,
              GetBuilder<AddMealController>(builder: (controller) {
                return SizedBox(
                  width: 1.sw,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: SearchBar(
                            key: addMealController.key1,
                            enabled:
                                !addMealController.tutorialCoachMark.isShowing,
                            addMealController:
                                addMealController.textEditingController,
                            focusNode: addMealController.focusNode,
                            onEditingComplete: () {
                              // addMealController.doSearchFood();
                              addMealController.onDoneInput();
                              addMealController.focusNode.unfocus();
                              addMealController.state.value =
                                  SearchStates.searchingWithResults;
                            },
                            onChanged: (val) =>
                                controller.hitsSearcher.query(val),
                          ),
                        ),
                      ),
                      controller.state.value ==
                              SearchStates.searchingWithResults
                          ? Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    //behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      AppNavigator.push(
                                          routeName: AppPages.requestFood,
                                          arguments: controller
                                              .textEditingController.text);
                                    },
                                    child: Container(
                                      width: 50.w,
                                      height: 50.h,
                                      key: addMealController.key3,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const SizedBox(
                                        child: Icon(
                                          Icons.add,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacer()
                                ],
                              ),
                            )
                          : Container()
                    ],
                  ),
                );
              }),
              Expanded(
                child: Obx(() {
                  return mapState(addMealController.tabController);
                }),
              ),
              Obx(() {
                return addMealController.state.value ==
                            SearchStates.searchingWithResults ||
                        addMealController.state.value ==
                            SearchStates.searchingWithRecommendation
                    ? Column(
                        children: [
                          24.verticalSpace,
                          LiveWellButton(
                              label: 'Done',
                              color: const Color(0xFFDDF235),
                              onPressed: addMealController.addedFoods.isEmpty
                                  ? null
                                  : () {
                                      AppNavigator.popUntil(
                                          routeName: AppPages.home);
                                    }),
                          20.verticalSpace,
                        ],
                      )
                    : Container();
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget mapState(TabController controller) {
    switch (addMealController.state.value) {
      case SearchStates.initial:
        return searchInitial();
      case SearchStates.searching:
        return ListOfSearchResults(
            addMealController: addMealController, type: type, date: date);
      case SearchStates.searchingWithResults:
        return searchResult(controller);
      case SearchStates.searchingWithRecommendation:
        return recommendationResults();
    }
  }

  Column searchResult(TabController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // TabBar(
        //   controller: controller,
        //   labelColor: const Color(0xFF171433),
        //   unselectedLabelColor: const Color(0xFF171433).withOpacity(0.3),
        //   indicatorWeight: 2.0,
        //   indicatorPadding: EdgeInsets.zero,
        //   indicator: const BubbleTabIndicator(
        //     indicatorHeight: 35.0,
        //     indicatorColor: Color(0xFFD8F3B1),
        //     tabBarIndicatorSize: TabBarIndicatorSize.tab,
        //   ),
        //   isScrollable: true,
        //   tabs: const [
        //     Tab(
        //       text: "All",
        //     ),
        //     Tab(
        //       text: "Brand Name",
        //     ),
        //   ],
        // ),
        Obx(() {
          if (addMealController.showRecommendationWidget.isTrue) {
            return InkWell(
              onTap: () {
                addMealController.onRecommendationWidgetTapped();
              },
              child: Column(
                children: [
                  24.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Container(
                      key: addMealController.key2,
                      width: 1.sw,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 16.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF171433),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 8.h),
                            width: 40.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.asset(Constant.icLunch),
                          ),
                          16.horizontalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Food Recommendation'.tr,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Based on your nutritional needs'.tr,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 8.h),
                            child: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.white,
                              size: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        }),
        24.verticalSpace,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                'Search Result'.tr,
                style: TextStyle(
                    fontSize: 20.sp,
                    color: const Color(0xFF171433),
                    fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              InkWell(
                key: addMealController.key4,
                onTap: () {
                  showModalBottomSheet<dynamic>(
                      context: context,
                      isScrollControlled: true,
                      shape: ShapeBorder.lerp(
                          const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          1),
                      builder: (BuildContext context) {
                        return Wrap(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Row(
                                      children: [
                                        Text('Filter'.tr,
                                            style: TextStyle(
                                                color: const Color(0xFF171433),
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16.sp)),
                                        const Spacer(),
                                        TextButton(
                                            onPressed: () {
                                              addMealController.resetFilter();
                                            },
                                            child: Text('Reset filter'.tr,
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xFF8F01DF),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12.sp))),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text('Amount'.tr,
                                        style: TextStyle(
                                            color: const Color(0xFF171433),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16.sp)),
                                  ),
                                  16.verticalSpace,
                                  Obx(() {
                                    return SearchFoodSliders(
                                        title: 'Calories'.tr,
                                        value: addMealController
                                            .caloriesRange.value,
                                        maxValue: 1500,
                                        onChanged: (value) {
                                          addMealController
                                              .caloriesRange.value = value;
                                        });
                                  }),
                                  24.verticalSpace,
                                  Obx(() {
                                    return SearchFoodSliders(
                                        title: 'Protein'.tr,
                                        value: addMealController
                                            .proteinRange.value,
                                        maxValue: 300,
                                        onChanged: (value) {
                                          addMealController.proteinRange.value =
                                              value;
                                        });
                                  }),
                                  24.verticalSpace,
                                  Obx(() {
                                    return SearchFoodSliders(
                                        title: 'Fat'.tr,
                                        value: addMealController.fatRange.value,
                                        maxValue: 200,
                                        onChanged: (value) {
                                          addMealController.fatRange.value =
                                              value;
                                        });
                                  }),
                                  24.verticalSpace,
                                  Obx(() {
                                    return SearchFoodSliders(
                                        title: 'Carbs'.tr,
                                        value:
                                            addMealController.carbsRange.value,
                                        maxValue: 400,
                                        onChanged: (value) {
                                          addMealController.carbsRange.value =
                                              value;
                                        });
                                  }),
                                  64.verticalSpace,
                                  LiveWellButton(
                                      label: 'Submit'.tr,
                                      color: const Color(0xFFDDF235),
                                      onPressed: () {
                                        addMealController.onSubmitFilter();
                                        Get.back();
                                      }),
                                  32.verticalSpace
                                ],
                              ),
                            ),
                          ],
                        );
                      });
                },
                child: const Icon(Icons.filter_list),
              )
            ],
          ),
        ),
        Expanded(
          child: ListOfSearchResults(
              addMealController: addMealController, type: type, date: date),
        ),
        // Expanded(
        //   child: TabBarView(
        //     controller: controller,
        //     children: [
        //       ListOfSearchResults(
        //           addMealController: addMealController, type: type, date: date),
        //       ListOfSearchResults(
        //           addMealController: addMealController, type: type, date: date),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  Column recommendationResults() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        24.verticalSpace,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    'Your Recommended Foods'.tr,
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: const Color(0xFF171433),
                        fontWeight: FontWeight.w600),
                  ),
                  4.verticalSpace,
                  Text(
                    'Picked based on your nutritional needs'.tr,
                    style: TextStyle(
                      color: const Color(0xFF171433),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  showModalBottomSheet<dynamic>(
                      context: context,
                      isScrollControlled: true,
                      shape: ShapeBorder.lerp(
                          const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          1),
                      builder: (BuildContext context) {
                        return Wrap(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Row(
                                      children: [
                                        Text('Filter'.tr,
                                            style: TextStyle(
                                                color: const Color(0xFF171433),
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16.sp)),
                                        const Spacer(),
                                        TextButton(
                                            onPressed: () {
                                              addMealController.resetFilter();
                                            },
                                            child: Text('Reset filter'.tr,
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xFF8F01DF),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12.sp))),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text('Amount'.tr,
                                        style: TextStyle(
                                            color: const Color(0xFF171433),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16.sp)),
                                  ),
                                  16.verticalSpace,
                                  Obx(() {
                                    return SearchFoodSliders(
                                        title: 'Calories'.tr,
                                        value: addMealController
                                            .caloriesRange.value,
                                        maxValue: 1500,
                                        onChanged: (value) {
                                          addMealController
                                              .caloriesRange.value = value;
                                        });
                                  }),
                                  24.verticalSpace,
                                  Obx(() {
                                    return SearchFoodSliders(
                                        title: 'Protein'.tr,
                                        value: addMealController
                                            .proteinRange.value,
                                        maxValue: 300,
                                        onChanged: (value) {
                                          addMealController.proteinRange.value =
                                              value;
                                        });
                                  }),
                                  24.verticalSpace,
                                  Obx(() {
                                    return SearchFoodSliders(
                                        title: 'Fat'.tr,
                                        value: addMealController.fatRange.value,
                                        maxValue: 200,
                                        onChanged: (value) {
                                          addMealController.fatRange.value =
                                              value;
                                        });
                                  }),
                                  24.verticalSpace,
                                  Obx(() {
                                    return SearchFoodSliders(
                                        title: 'Carbs'.tr,
                                        value:
                                            addMealController.carbsRange.value,
                                        maxValue: 400,
                                        onChanged: (value) {
                                          addMealController.carbsRange.value =
                                              value;
                                        });
                                  }),
                                  64.verticalSpace,
                                  LiveWellButton(
                                      label: 'Submit'.tr,
                                      color: const Color(0xFFDDF235),
                                      onPressed: () {
                                        addMealController.onSubmitFilter();
                                        Get.back();
                                      }),
                                  32.verticalSpace
                                ],
                              ),
                            ),
                          ],
                        );
                      });
                },
                child: const Icon(Icons.filter_list),
              )
            ],
          ),
        ),
        Expanded(
          child: ListOfSearchResults(
              addMealController: addMealController, type: type, date: date),
        ),
      ],
    );
  }

  SingleChildScrollView searchInitial() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(() {
                return SizedBox(
                  height: addMealController.showScanMenu().value ? 159.h : 0.h,
                  child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return addMealController
                                .checkAvailability(ScanType.values[index])
                                .value
                            ? Expanded(
                                child: scanButton(ScanType.values[index],
                                    () async {
                                AppNavigator.push(
                                    routeName:
                                        "${AppPages.scanFood}/${ScanType.values[index].name}");
                              }))
                            : Container();
                      },
                      separatorBuilder: (context, index) {
                        return addMealController
                                .checkAvailability(ScanType.values[index])
                                .value
                            ? 20.horizontalSpace
                            : Container();
                      },
                      itemCount: ScanType.values.length),
                );
              })),
          const SizedBox(height: 32),
          Obx(() {
            if (addMealController.history.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16).r,
                child: Text(
                  'History',
                  style: TextStyle(
                      fontSize: 22.sp,
                      color: const Color(0xFF171433),
                      fontWeight: FontWeight.w600),
                ),
              );
            } else {
              return Container();
            }
          }),
          Obx(
            () {
              if (addMealController.history.isNotEmpty) {
                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: addMealController.history.length >= 5
                      ? 5
                      : addMealController.history.length,
                  itemBuilder: (context, index) {
                    return Obx(() {
                      return SearchHistoryItem(
                        title: addMealController.history[index].mealName ?? "",
                        description:
                            "${addMealController.history[index].mealServings}",
                        isAdded: false,
                        callback: () {
                          inspect(addMealController.history[index]);
                          Get.to(
                              () => AddFoodScreen(
                                    food: addMealController.history[index]
                                        .toFoodsObject(),
                                    mealTime: MealTime.values.byName(
                                        (type ?? MealTime.breakfast.name)
                                            .toLowerCase()),
                                  ),
                              transition: Transition.cupertino,
                              arguments: date);
                        },
                      );
                    });
                  },
                  separatorBuilder: (context, index) {
                    return 16.verticalSpace;
                  },
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget scanButton(ScanType type, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 153.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding:
            const EdgeInsets.only(top: 15, left: 18, bottom: 12, right: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SvgPicture.asset(
                type.asset(),
                width: 30,
                height: 30,
                fit: BoxFit.scaleDown,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              type.title(),
              style: TextStyle(
                  fontSize: 16.sp,
                  color: const Color(0xFF171433),
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}

class ListOfSearchResults extends StatelessWidget {
  const ListOfSearchResults({
    Key? key,
    required this.addMealController,
    required this.type,
    required this.date,
  }) : super(key: key);

  final AddMealController addMealController;
  final String? type;
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _hits(context),
        )
      ],
    );
  }

  Widget _hits(BuildContext context) => PagedListView<int, Foods>(
      pagingController: addMealController.pagingController,
      builderDelegate: PagedChildBuilderDelegate<Foods>(
          noItemsFoundIndicatorBuilder: (_) => Center(
                child: Text('No results found'.tr),
              ),
          itemBuilder: (_, item, __) => Column(
                children: [
                  Obx(() {
                    return SearchHistoryItem(
                        title: item.foodName ?? "",
                        description: item.desc(),
                        isAdded: addMealController.addedFoods.firstWhereOrNull(
                                (element) =>
                                    element.foodName == item.foodName) !=
                            null,
                        callback: () {
                          Get.to(
                              () => AddFoodScreen(
                                    food: item,
                                    mealTime: MealTime.values.byName(
                                        (type ?? MealTime.breakfast.name)
                                            .toLowerCase()),
                                  ),
                              transition: Transition.cupertino,
                              arguments: date);
                        });
                  }),
                  8.verticalSpace,
                ],
              )));
}

class SearchBar extends StatelessWidget {
  const SearchBar(
      {Key? key,
      required this.addMealController,
      required this.focusNode,
      required this.onEditingComplete,
      required this.onChanged,
      required this.enabled})
      : super(key: key);

  final TextEditingController addMealController;
  final FocusNode focusNode;
  final VoidCallback onEditingComplete;
  final ValueChanged<String>? onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        enabled: enabled,
        controller: addMealController,
        onEditingComplete: () {
          onEditingComplete();
        },
        onChanged: onChanged,
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        focusNode: focusNode,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 20.h, bottom: 16.h),
            border: InputBorder.none,
            hintText: 'Search here...'.tr,
            hintStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
            prefixIcon: Image.asset(
              Constant.icSearch,
              scale: 1,
            ),
            suffixIcon: addMealController.text.isEmpty
                ? null
                : IconButton(
                    onPressed: () {
                      addMealController.clear();
                    },
                    icon: const Icon(Icons.clear_rounded))),
      ),
    );
  }
}

class SearchHistoryItem extends StatelessWidget {
  final String title;
  final String description;
  final bool isAdded;
  final VoidCallback callback;

  const SearchHistoryItem(
      {Key? key,
      required this.title,
      required this.description,
      required this.isAdded,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: isAdded ? const Color(0xFF8F01DF) : Colors.transparent)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: const Color(0xFF171433).withOpacity(0.8),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  description.isEmpty
                      ? Container()
                      : Text(
                          description,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: const Color(0xFF171433).withOpacity(0.5),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500),
                        ),
                ],
              ),
            ),
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F1F1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
                size: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}

enum ScanType {
  barcode,
  photo,
}

extension ScanTypeAtt on ScanType {
  String title() {
    switch (this) {
      case ScanType.barcode:
        return 'Scan a barcode'.tr;
      case ScanType.photo:
        return 'Scan a meal'.tr;
    }
  }

  String asset() {
    switch (this) {
      case ScanType.barcode:
        return Constant.icBarcode;
      case ScanType.photo:
        return Constant.icScanMeal;
    }
  }
}

class SearchFoodSliders extends StatefulWidget {
  const SearchFoodSliders(
      {super.key,
      required this.title,
      required this.value,
      required this.maxValue,
      required this.onChanged});

  final String title;
  final RangeValues value;
  final double maxValue;
  final ValueChanged<RangeValues> onChanged;

  @override
  State<SearchFoodSliders> createState() => _SearchFoodSlidersState();
}

class _SearchFoodSlidersState extends State<SearchFoodSliders> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(widget.title,
              style: TextStyle(
                  color: const Color(0xFF171433),
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp)),
        ),
        8.verticalSpace,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(widget.value.start.toStringAsFixed(0)),
              const Spacer(),
              Text(widget.value.end.toStringAsFixed(0)),
            ],
          ),
        ),
        SliderTheme(
            data: SliderTheme.of(context).copyWith(
                trackHeight: 12,
                thumbColor: Colors.black,
                activeTrackColor: const Color(0xFF34EAB2),
                inactiveTrackColor: const Color(0XFFF1F1F1),
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
                minThumbSeparation: 0),
            child: RangeSlider(
                values: widget.value,
                min: 0.0,
                max: widget.maxValue,
                onChanged: (value) {
                  widget.onChanged(value);
                })),
      ],
    );
  }
}

class CoachmarkIndicator extends StatelessWidget {
  final int position;
  final int length;
  const CoachmarkIndicator(
      {super.key, required this.position, this.length = 4});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(length, (index) {
        if ((index) == position) {
          return Padding(
            padding: EdgeInsets.only(left: index == 0 ? 0 : 8.w),
            child: Container(
              width: 24.w,
              height: 8.h,
              decoration: BoxDecoration(
                  color: const Color(0xFF8F01DF),
                  borderRadius: BorderRadius.circular(100)),
            ),
          );
        } else {
          return Padding(
            padding: EdgeInsets.only(left: index == 0 ? 0 : 8.w),
            child: Container(
              width: 8.w,
              height: 8.h,
              decoration: BoxDecoration(
                  color: const Color(0xFF808080),
                  borderRadius: BorderRadius.circular(100)),
            ),
          );
        }
      }),
    );
  }
}
