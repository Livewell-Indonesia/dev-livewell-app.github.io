import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/diary/domain/entity/user_meal_history_model.dart';
import 'package:livewell/feature/diary/presentation/controller/user_diary_controller.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../routes/app_navigator.dart';
import '../../../food/presentation/pages/add_meal_screen.dart';

class UserDiaryScreen extends StatelessWidget {
  final UserDiaryController controller = Get.put(UserDiaryController());
  UserDiaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: "Diary",
        body: Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                55.verticalSpace,
                // Container(
                //   height: 28.h,
                //   width: 1.sw,
                //   padding: EdgeInsets.symmetric(horizontal: 24.w),
                //   alignment: Alignment.center,
                //   child: ListView.separated(
                //       scrollDirection: Axis.horizontal,
                //       itemBuilder: (context, index) {
                //         return InkWell(
                //           onTap: () {
                //             controller.diaryType.value =
                //                 DiaryType.values[index];
                //           },
                //           child: Obx(() {
                //             return Container(
                //               width: 74.w,
                //               height: 28.h,
                //               alignment: Alignment.center,
                //               decoration: BoxDecoration(
                //                 color: controller.diaryType.value ==
                //                         DiaryType.values[index]
                //                     ? const Color(0xFFDDF235)
                //                     : Colors.white,
                //                 borderRadius: BorderRadius.circular(20).r,
                //               ),
                //               child: Text(
                //                 DiaryType.values[index].name,
                //                 style: TextStyle(
                //                   fontSize: 12.sp,
                //                   fontWeight: FontWeight.w500,
                //                   color: controller.diaryType.value ==
                //                           DiaryType.values[index]
                //                       ? const Color(0xFF171433)
                //                       : const Color(0xFF171433)
                //                           .withOpacity(0.5),
                //                 ),
                //               ),
                //             );
                //           }),
                //         );
                //       },
                //       separatorBuilder: (context, index) {
                //         return 10.horizontalSpace;
                //       },
                //       itemCount: DiaryType.values.length),
                // ),
                // 40.verticalSpace,
                Container(
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
                                  ? Color(0xFF171433).withOpacity(0.5)
                                  : Color(0xFF171433),
                            )),
                        Column(
                          children: [
                            Text(
                                DateFormat('MMMM').format(controller
                                    .dateList[controller.selectedIndex.value]),
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
                                  ? Color(0xFF171433).withOpacity(0.5)
                                  : Color(0xFF171433),
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
                                    color:
                                        controller.selectedIndex.value == index
                                            ? const Color(0xFFDDF235)
                                            : const Color(0xFFDDF235)
                                                .withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10).r),
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
                              title: "Breakfast",
                              data: controller.filteredMealHistory
                                  .where((p0) =>
                                      p0.mealType?.toUpperCase() ==
                                      "breakfast".toUpperCase())
                                  .toList(),
                              onTap: () {
                                AppNavigator.push(
                                    routeName: '${AppPages.addMeal}/breakfast',
                                    arguments: controller.dateList[
                                        controller.selectedIndex.value]);
                              },
                            ),
                            20.verticalSpace,
                            ExpandableDiaryItem(
                              title: "Lunch",
                              data: controller.filteredMealHistory
                                  .where((p0) =>
                                      p0.mealType?.toUpperCase() ==
                                      "lunch".toUpperCase())
                                  .toList(),
                              onTap: () {
                                AppNavigator.push(
                                    routeName: '${AppPages.addMeal}/lunch',
                                    arguments: controller.dateList[
                                        controller.selectedIndex.value]);
                              },
                            ),
                            20.verticalSpace,
                            ExpandableDiaryItem(
                              title: "Dinner",
                              data: controller.filteredMealHistory
                                  .where((p0) =>
                                      p0.mealType?.toUpperCase() ==
                                      "dinner".toUpperCase())
                                  .toList(),
                              onTap: () {
                                AppNavigator.push(
                                    routeName: '${AppPages.addMeal}/dinner',
                                    arguments: controller.dateList[
                                        controller.selectedIndex.value]);
                              },
                            ),
                            20.verticalSpace,
                          ],
                        );
                })
              ],
            ),
          ),
        ));
  }
}

class ExpandableDiaryItem extends StatelessWidget {
  final String title;
  final List<MealHistoryModel> data;
  VoidCallback onTap;
  ExpandableDiaryItem(
      {Key? key, required this.title, required this.data, required this.onTap})
      : super(key: key);

  int getTotalCal(List<MealHistoryModel> mealHistory) {
    var totalCal = 0;
    for (var element in mealHistory) {
      totalCal += element.caloriesInG!;
    }
    if (totalCal > 0) {
      totalCal = (totalCal * 7.7162).round();
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
                      text: 'kcal',
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
                      data.isNotEmpty ? Icons.keyboard_arrow_down : Icons.add,
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
                      return Container(
                        padding: EdgeInsets.fromLTRB(26.w, 0.h, 16.w, 0.h),
                        height: 47.h,
                        alignment: Alignment.center,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[item].mealName ?? "",
                                  style: TextStyle(
                                      color: const Color(0xFF171433)
                                          .withOpacity(0.8),
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '22 Teaspoons',
                                  style: TextStyle(
                                      color: const Color(0xFF171433)
                                          .withOpacity(0.7),
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            const Spacer(),
                            Text(
                              '${(data[item].caloriesInG! * 7.7162).round()} kcal',
                              style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF8F01DF)),
                            )
                          ],
                        ),
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
