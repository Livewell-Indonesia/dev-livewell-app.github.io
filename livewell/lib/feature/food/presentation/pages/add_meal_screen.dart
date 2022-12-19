import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/feature/food/presentation/controller/add_meal_controller.dart';
import 'package:livewell/feature/food/presentation/pages/add_food_screen.dart';
import 'package:livewell/feature/food/presentation/pages/food_screen.dart';
import 'package:livewell/routes/app_navigator.dart';
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
  String? type;
  DateTime? date;

  @override
  void initState() {
    type = Get.arguments['type'];
    date = Get.arguments['date'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
      title: MealTime.values
          .byName((type ?? MealTime.breakfast.name).toLowerCase())
          .appBarTitle(),
      body: Expanded(
        child: Column(
          children: [
            const SizedBox(
              height: 48,
            ),
            GetBuilder<AddMealController>(builder: (controller) {
              return SizedBox(
                width: 1.sw,
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: SearchBar(
                        addMealController:
                            addMealController.textEditingController,
                        focusNode: addMealController.focusNode,
                        onEditingComplete: () {
                          // addMealController.doSearchFood();
                          addMealController.focusNode.unfocus();
                        },
                        onChanged: (val) => controller.hitsSearcher.query(val),
                      ),
                    ),
                    controller.state.value == SearchStates.searchingWithResults
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
                                    width: 50,
                                    height: 50,
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
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Obx(() {
                return mapState(addMealController.tabController);
              }),
            ),
          ],
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
              text: "Brand Name",
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: [
              ListOfSearchResults(
                  addMealController: addMealController, type: type, date: date),
              Column(
                children: [
                  Expanded(
                    child: Obx(
                      () {
                        if (addMealController.brandNameResult.isNotEmpty) {
                          return ListView.separated(
                            //physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: addMealController.results.length,
                            itemBuilder: (context, index) {
                              return SearchHistoryItem(
                                title: addMealController
                                        .brandNameResult[index].foodName ??
                                    "",
                                description: addMealController
                                    .brandNameResult[index].foodDesc,
                                callback: () {
                                  Get.to(
                                      () => AddFoodScreen(
                                            food: addMealController
                                                .brandNameResult[index],
                                            mealTime: MealTime.values.byName(
                                                (type ??
                                                        MealTime.breakfast.name)
                                                    .toLowerCase()),
                                          ),
                                      transition: Transition.cupertino,
                                      arguments: date);
                                },
                              );
                            },
                            separatorBuilder: (context, index) {
                              return 16.verticalSpace;
                            },
                          );
                        } else {
                          return const Center(
                            child: Text('No Result Found'),
                          );
                        }
                      },
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
                    return SearchHistoryItem(
                      title: addMealController.history[index].mealName ?? "",
                      description:
                          "${addMealController.history[index].mealServings}",
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
            child: StreamBuilder<SearchResponse>(
          stream: addMealController.hitsSearcher.responses,
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              final response = snapshot.data;
              final hits = response?.hits.toList() ?? [];
              return ListView.separated(
                itemCount: hits.length,
                itemBuilder: (context, index) {
                  return SearchHistoryItem(
                    title: snapshot.data!.hits[index]['food_name'],
                    description: snapshot.data!.hits[index]['food_name'],
                    callback: () {
                      // Get.to(
                      //     () => AddFoodScreen(
                      //           food: snapshot.data!.hits[index].food.toFoodsObject(),
                      //           mealTime: MealTime.values.byName(
                      //               (type ?? MealTime.breakfast.name)
                      //                   .toLowerCase()),
                      //         ),
                      //     transition: Transition.cupertino,
                      //     arguments: date);
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
        )),
      ],
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar(
      {Key? key,
      required this.addMealController,
      required this.focusNode,
      required this.onEditingComplete,
      required this.onChanged})
      : super(key: key);

  final TextEditingController addMealController;
  final FocusNode focusNode;
  final VoidCallback onEditingComplete;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        controller: addMealController,
        onEditingComplete: () {
          onEditingComplete();
        },
        onChanged: onChanged,
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        focusNode: focusNode,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 20, bottom: 16),
            border: InputBorder.none,
            hintText: 'Search here...',
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
  final VoidCallback callback;

  const SearchHistoryItem(
      {Key? key,
      required this.title,
      required this.description,
      required this.callback})
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
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Color(0xFF171433).withOpacity(0.8),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  description.isEmpty
                      ? Container()
                      : Text(
                          description,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Color(0xFF171433).withOpacity(0.5),
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
