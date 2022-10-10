import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/food/presentation/controller/add_meal_controller.dart';
import 'package:livewell/feature/food/presentation/pages/add_food_screen.dart';
import 'package:livewell/feature/food/presentation/pages/food_screen.dart';
import 'package:livewell/feature/food/presentation/pages/scan_barcode_screen.dart';
import 'package:livewell/feature/food/presentation/pages/scan_food_screen.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/theme/design_system.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';
import 'dart:developer';

class AddMealScreen extends StatefulWidget {
  AddMealScreen({Key? key}) : super(key: key);

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen>
    with TickerProviderStateMixin {
  final AddMealController addMealController = Get.put(AddMealController());

  @override
  Widget build(BuildContext context) {
    TabController controller = TabController(length: 3, vsync: this);
    return LiveWellScaffold(
      title: MealTime.values.byName(Get.parameters['type']!).appBarTitle(),
      body: Expanded(
        child: Column(
          children: [
            const SizedBox(
              height: 48,
            ),
            searchBar(),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Obx(() {
                return mapState(controller);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget mapState(TabController controller) {
    switch (addMealController.state.value) {
      case SearchState.initial:
        return searchInitial();
      case SearchState.searching:
        return Container();
      case SearchState.searchingWithResults:
        return searchResult(controller);
    }
  }

  Column searchResult(TabController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TabBar(
          controller: controller,
          labelColor: const Color(0xFF171433),
          unselectedLabelColor: const Color(0xFF171433).withOpacity(0.3),
          indicatorWeight: 2.0,
          indicatorPadding: EdgeInsets.zero,
          indicator: const BubbleTabIndicator(
            indicatorHeight: 35.0,
            indicatorColor: Color(0xFFD8F3B1),
            tabBarIndicatorSize: TabBarIndicatorSize.tab,
          ),
          isScrollable: true,
          tabs: const [
            Tab(
              text: "All",
            ),
            Tab(
              text: "Local F&B",
            ),
            Tab(
              text: "Brand Name",
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: [
              Column(
                children: [
                  Expanded(
                    child: Obx(
                      () {
                        if (addMealController.results.isNotEmpty) {
                          return ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: addMealController.results.value.length,
                            itemBuilder: (context, index) {
                              return SearchHistoryItem(
                                title:
                                    addMealController.results[index].foodName ??
                                        "",
                                callback: () {
                                  Get.to(
                                      () => AddFoodScreen(
                                            food: addMealController
                                                .results[index],
                                            mealTime: MealTime.values.byName(
                                                Get.parameters['type']!),
                                          ),
                                      transition: Transition.cupertino,
                                      arguments: Get.arguments);
                                },
                              );
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
                  ),
                ],
              ),
              Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  SingleChildScrollView searchInitial() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                    child: scanButton(ScanType.barcode, () async {
                  AppNavigator.push(
                      routeName:
                          "${AppPages.scanFood}/${ScanType.barcode.name}");
                })),
                const SizedBox(width: 24),
                Expanded(
                    child: scanButton(ScanType.photo, () async {
                  Get.to(ScanFoodScreen());
                })),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16).r,
            child: Text(
              'History',
              style: TextStyle(
                  fontSize: 22.sp,
                  color: const Color(0xFF171433),
                  fontWeight: FontWeight.w600),
            ),
          ),
          Obx(
            () {
              if (addMealController.history.isNotEmpty) {
                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return SearchHistoryItem(
                      title: addMealController.history[index].foodName ?? "",
                      callback: () {
                        inspect(addMealController.history[index]);
                        Get.to(
                            () => AddFoodScreen(
                                  food: addMealController.history[index],
                                  mealTime: MealTime.values
                                      .byName(Get.parameters['type']!),
                                ),
                            transition: Transition.cupertino,
                            arguments: Get.arguments);
                      },
                    );
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

  Container searchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        controller: addMealController.textEditingController,
        onEditingComplete: () {
          addMealController.doSearchFood();
          addMealController.focusNode.unfocus();
        },
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        focusNode: addMealController.focusNode,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 20, bottom: 16),
          border: InputBorder.none,
          hintText: 'Search here...',
          hintStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          prefixIcon: Image.asset(
            Constant.icSearch,
            scale: 1,
          ),
        ),
      ),
    );
  }

  Widget scanButton(ScanType type, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
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

class SearchHistoryItem extends StatelessWidget {
  final String title;
  final VoidCallback callback;

  const SearchHistoryItem(
      {Key? key, required this.title, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Color(0xFF171433).withOpacity(0.8),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600),
            ),
            Spacer(),
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: Color(0xFFF1F1F1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
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
        return 'Scan a barcode';
      case ScanType.photo:
        return 'Scan a meal';
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
