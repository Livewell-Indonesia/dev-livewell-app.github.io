import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:livewell/feature/diary/domain/entity/user_meal_history_model.dart';
import 'package:livewell/feature/diary/presentation/controller/user_diary_controller.dart';
import 'package:livewell/feature/food/presentation/pages/food_screen.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../routes/app_navigator.dart';
import '../../../../theme/design_system.dart';

class UserDiaryScreen extends StatelessWidget {
  final UserDiaryController controller = Get.put(UserDiaryController());
  UserDiaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: "Diary".tr,
        body: Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              controller.onInit();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  55.verticalSpace,
                  SizedBox(
                    width: 1.sw,
                    child: Obx(() {
                      return Row(
                        children: [
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                controller.onPreviousTapped();
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 20.r,
                                color: controller.selectedIndex.value == 0
                                    ? const Color(0xFF171433).withOpacity(0.5)
                                    : const Color(0xFF171433),
                              )),
                          Column(
                            children: [
                              Text(
                                  DateFormat('MMMM').format(controller.dateList[
                                      controller.selectedIndex.value]),
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF171433)
                                          .withOpacity(0.7))),
                              Text(
                                DateFormat('EEEE, d').format(controller
                                    .dateList[controller.selectedIndex.value]),
                                style: TextStyle(
                                    fontSize: 24.sp,
                                    color: const Color(0xFF171433),
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                controller.onNextTapped();
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 20.r,
                                color: controller.selectedIndex.value ==
                                        controller.dateList.length - 1
                                    ? const Color(0xFF171433).withOpacity(0.5)
                                    : const Color(0xFF171433),
                              )),
                          const Spacer()
                        ],
                      );
                    }),
                  ),
                  25.verticalSpace,
                  Container(
                    height: 72.h,
                    width: 1.sw,
                    alignment: Alignment.center,
                    child: Obx(() {
                      return ScrollablePositionedList.separated(
                          itemScrollController: controller.itemScrollController,
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: ((context, index) {
                            return Obx(() {
                              return InkWell(
                                onTap: () {
                                  controller.onDateTapped(index);
                                },
                                child: Container(
                                  width: 55.w,
                                  height: 72.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: controller.selectedIndex.value ==
                                              index
                                          ? const Color(0xFFDDF235)
                                          : const Color(0xFFDDF235)
                                              .withOpacity(0.2),
                                      borderRadius:
                                          BorderRadius.circular(10).r),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        DateFormat('EEE')
                                            .format(controller.dateList[index]),
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            color: const Color(0xFF171433),
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                          controller.dateList[index].day
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 19.sp,
                                              color: const Color(0xFF171433),
                                              fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                ),
                              );
                            });
                          }),
                          separatorBuilder: (context, index) {
                            return 20.horizontalSpace;
                          },
                          itemCount: controller.dateList.length);
                    }),
                  ),
                  40.verticalSpace,
                  Obx(() {
                    return controller.isLoading.value
                        ? Container()
                        : Column(
                            children: [
                              ExpandableDiaryItem(
                                title: "Breakfast".tr,
                                data: controller.filteredMealHistory
                                    .where((p0) =>
                                        p0.mealType?.toUpperCase() ==
                                        "breakfast".toUpperCase())
                                    .toList(),
                                onTap: () {
                                  AppNavigator.push(
                                      routeName: AppPages.addMeal,
                                      arguments: {
                                        "type": "breakfast",
                                        "date": controller.dateList[
                                            controller.selectedIndex.value]
                                      });
                                },
                                onUpdate: (index, size) {
                                  controller.onUpdateTapped(
                                      MealTime.breakfast, index, size);
                                },
                                onDelete: (index) {
                                  controller.onDeleteTapped(
                                      MealTime.breakfast, index);
                                },
                              ),
                              20.verticalSpace,
                              ExpandableDiaryItem(
                                title: "Lunch".tr,
                                data: controller.filteredMealHistory
                                    .where((p0) =>
                                        p0.mealType?.toUpperCase() ==
                                        "lunch".toUpperCase())
                                    .toList(),
                                onTap: () {
                                  AppNavigator.push(
                                      routeName: AppPages.addMeal,
                                      arguments: {
                                        "type": "lunch",
                                        "date": controller.dateList[
                                            controller.selectedIndex.value]
                                      });
                                },
                                onUpdate: (index, size) {
                                  controller.onUpdateTapped(
                                      MealTime.lunch, index, size);
                                },
                                onDelete: (index) {
                                  controller.onDeleteTapped(
                                      MealTime.lunch, index);
                                },
                              ),
                              20.verticalSpace,
                              ExpandableDiaryItem(
                                title: "Dinner".tr,
                                data: controller.filteredMealHistory
                                    .where((p0) =>
                                        p0.mealType?.toUpperCase() ==
                                        "dinner".toUpperCase())
                                    .toList(),
                                onTap: () {
                                  AppNavigator.push(
                                      routeName: AppPages.addMeal,
                                      arguments: {
                                        "type": "dinner",
                                        "date": controller.dateList[
                                            controller.selectedIndex.value]
                                      });
                                },
                                onUpdate: (index, size) {
                                  controller.onUpdateTapped(
                                      MealTime.dinner, index, size);
                                },
                                onDelete: (index) {
                                  controller.onDeleteTapped(
                                      MealTime.dinner, index);
                                },
                              ),
                              20.verticalSpace,
                              ExpandableDiaryItem(
                                title: "Snack".tr,
                                data: controller.filteredMealHistory
                                    .where((p0) =>
                                        p0.mealType?.toUpperCase() ==
                                        "snack".toUpperCase())
                                    .toList(),
                                onTap: () {
                                  AppNavigator.push(
                                      routeName: AppPages.addMeal,
                                      arguments: {
                                        "type": "snack",
                                      });
                                },
                                onUpdate: (index, size) {
                                  controller.onUpdateTapped(
                                      MealTime.snack, index, size);
                                },
                                onDelete: (index) {
                                  controller.onDeleteTapped(
                                      MealTime.snack, index);
                                },
                              ),
                              20.verticalSpace,
                            ],
                          );
                  })
                ],
              ),
            ),
          ),
        ));
  }
}

class ExpandableDiaryItem extends StatelessWidget {
  final String title;
  final List<MealHistoryModel> data;
  final VoidCallback onTap;
  final void Function(int) onDelete;
  final void Function(int index, double value) onUpdate;
  const ExpandableDiaryItem(
      {Key? key,
      required this.title,
      required this.data,
      required this.onTap,
      required this.onUpdate,
      required this.onDelete})
      : super(key: key);

  num getTotalCal(List<MealHistoryModel> mealHistory) {
    num totalCal = 0;
    for (var element in mealHistory) {
      totalCal += element.caloriesInG!;
    }
    if (totalCal > 0) {
      totalCal = (totalCal).round();
    }
    return totalCal;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              height: 72.h,
              padding: EdgeInsets.fromLTRB(26.w, 20.h, 16.w, 18.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                  bottomLeft: data.isNotEmpty
                      ? Radius.circular(0.r)
                      : Radius.circular(30.r),
                  bottomRight: data.isNotEmpty
                      ? Radius.circular(0.r)
                      : Radius.circular(30.r),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '$title: ',
                    style: TextStyle(
                        color: const Color(0xFF171433).withOpacity(0.8),
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: '${getTotalCal(data)} ',
                        style: TextStyle(
                            color: const Color(0xFF8F01DF),
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600)),
                    TextSpan(
                      text: 'cal',
                      style: TextStyle(
                          color: const Color(0xFF171433).withOpacity(0.7),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500),
                    )
                  ])),
                  const Spacer(),
                  Container(
                    width: 35.w,
                    height: 35.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F1F1),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.add,
                      color: const Color(0xFF171433).withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          data.isNotEmpty
              ? Flexible(
                  child: ListView.separated(
                    padding: EdgeInsets.only(top: 20.h),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, item) {
                      return HistoryContent(
                        onDelete: onDelete,
                        onUpdate: onUpdate,
                        data: data,
                        index: item,
                      );
                    },
                    separatorBuilder: (context, item) {
                      return Padding(
                        padding: EdgeInsets.only(top: 7.5.h, bottom: 7.5.h),
                        child: const Divider(),
                      );
                    },
                    itemCount: data.length,
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}

class HistoryContent extends StatefulWidget {
  const HistoryContent({
    Key? key,
    required this.onDelete,
    required this.onUpdate,
    required this.data,
    required this.index,
  }) : super(key: key);

  final void Function(int p1) onDelete;
  final void Function(int index, double servingSize) onUpdate;
  final List<MealHistoryModel> data;
  final int index;

  @override
  State<HistoryContent> createState() => _HistoryContentState();
}

class _HistoryContentState extends State<HistoryContent> {
  bool isExpanded = false;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: false,
      actions: [
        KeyboardActionsItem(
          focusNode: _focusNode,
          toolbarButtons: [
            (node) {
              return GestureDetector(
                onTap: () => node.unfocus(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("done".tr),
                ),
              );
            }
          ],
        ),
      ],
    );
  }

  @override
  void initState() {
    _controller.text = (widget.data[widget.index].servingSize ?? 1).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(isExpanded ? 0.w : 26.w, 0.h, 16.w, 0.h),
        height: isExpanded ? 100.h : 50.h,
        alignment: Alignment.center,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isExpanded ? 8.horizontalSpace : 0.horizontalSpace,
                isExpanded
                    ? KeyboardActions(
                        config: _buildConfig(context),
                        disableScroll: true,
                        child: Container(
                            height: 40.h,
                            width: 60.w,
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Center(
                              child: TextFormField(
                                focusNode: _focusNode,
                                textInputAction: TextInputAction.done,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        signed: false, decimal: true),
                                inputFormatters: Platform.isIOS
                                    ? []
                                    : [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^\d+\.?\d{0,2}'))
                                      ],
                                controller: _controller,
                                style: TextStyle(
                                    color: const Color(0xFF171433)
                                        .withOpacity(0.7),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.all(8)),
                              ),
                            )),
                      )
                    : Container(),
                isExpanded ? 8.horizontalSpace : 0.horizontalSpace,
                Expanded(
                  flex: isExpanded ? 5 : 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data[widget.index].mealName ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: const Color(0xFF171433).withOpacity(0.8),
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        widget.data[widget.index].mealServings ?? "",
                        style: TextStyle(
                            color: const Color(0xFF171433).withOpacity(0.7),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                //const Spacer(),
                Expanded(
                  flex: 2,
                  child: Text(
                    '${(widget.data[widget.index].caloriesInG!).round()} cal',
                    style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF8F01DF)),
                  ),
                )
              ],
            ),
            isExpanded
                ? Row(
                    children: [
                      Expanded(
                        child: LiveWellSmallButton(
                            textColor: Colors.white,
                            label: "update",
                            color: Colors.green,
                            onPressed: () {
                              widget.onUpdate(
                                  widget.index,
                                  double.parse(_controller.text
                                      .trim()
                                      .replaceAll(',', '.')));
                            }),
                      ),
                      Expanded(
                        child: LiveWellSmallButton(
                            textColor: Colors.white,
                            label: "delete",
                            color: Colors.red,
                            onPressed: () {
                              widget.onDelete(widget.index);
                            }),
                      )
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

class LiveWellSmallButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;
  final Color? textColor;
  const LiveWellSmallButton(
      {required this.label,
      required this.color,
      required this.onPressed,
      this.textColor,
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
            backgroundColor: color,
            minimumSize: Size(double.infinity, 22.w),
            padding: const EdgeInsets.symmetric(
                    horizontal: Insets.paddingMedium, vertical: 12.0)
                .r,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36.0).r)),
        child: Text(
          label,
          style: TextStyle(
              color: textColor ?? Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
