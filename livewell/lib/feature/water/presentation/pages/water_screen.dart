import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:livewell/core/helper/tracker/livewell_tracker.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/feature/water/data/model/water_list_model.dart';
import 'package:livewell/feature/water/presentation/controller/water_controller.dart';
import 'package:livewell/feature/water/presentation/pages/water_custom_input_page.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
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
        child: RefreshIndicator(
          onRefresh: () async {
            controller.getWaterData();
          },
          child: ListView(
            children: [
              40.verticalSpace,
              Obx(() {
                return RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(text: controller.localization.yourWaterIntakeForToday!, style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w600, color: const Color(0xFF171433))),
                      TextSpan(text: controller.waterConsumed.value.toStringAsFixed(1), style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w600, color: const Color(0xFF8F01DF))),
                    ]));
              }),
              32.verticalSpace,
              Obx(() {
                return DrinkIndicator(
                  value: controller.waterConsumedPercentage.value,
                  label: controller.waterConsumed.value.toStringAsFixed(1),
                );
              }),
              Obx(() {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16),
                  child: WaterRuler(
                    value: controller.waterConsumedPercentage.value,
                  ),
                );
              }),
              32.verticalSpace,
              // Obx(() {
              //   return WaterHistoriesWidget(
              //     waterHistories: contoller.waterList.value,
              //   );
              // }),
              // Container(
              //   margin: const EdgeInsets.symmetric(horizontal: 16),
              //   padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(30),
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       const Padding(
              //         padding: EdgeInsets.only(bottom: 18.0),
              //         child: Text("Last Update",
              //             style: TextStyle(
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w700,
              //                 color: Color(0xFF171433))),
              //       ),
              //       ListView.separated(
              //           physics: const NeverScrollableScrollPhysics(),
              //           shrinkWrap: true,
              //           itemCount: 2,
              //           itemBuilder: (context, index) {
              //             return Row(
              //               children: [
              //                 Text('Water',
              //                     style: TextStyle(
              //                       fontSize: 16.sp,
              //                       fontWeight: FontWeight.w500,
              //                       color: const Color(0xFF171433),
              //                     )),
              //                 const Spacer(),
              //                 Text('50 ml',
              //                     style: TextStyle(
              //                         fontSize: 16.sp,
              //                         color: const Color(0xFF171433),
              //                         fontWeight: FontWeight.w500)),
              //               ],
              //             );
              //           },
              //           separatorBuilder: (context, index) {
              //             return const Padding(
              //               padding: EdgeInsets.symmetric(vertical: 8.0),
              //               child: Divider(),
              //             );
              //           }),
              //     ],
              //   ),
              // ),
              40.verticalSpace,
              LiveWellButton(
                  label: controller.localization.addDrink!,
                  color: const Color(0xFF8F01DF),
                  textColor: const Color(0xFFFFFFFF),
                  onPressed: () {
                    controller.trackEvent(LivewellWaterEvent.waterPageAddDrinkButton);
                    AppNavigator.push(routeName: AppPages.waterConsumedPage, arguments: {"waterInputType": WaterInputType.increase});
                  }),
              20.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      side: const BorderSide(width: 2, color: Color(0xFF8F01DF)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    onPressed: () {
                      controller.trackEvent(LivewellWaterEvent.waterPageReduceWaterButton);
                      AppNavigator.push(routeName: AppPages.waterConsumedPage, arguments: {"waterInputType": WaterInputType.reduce});
                    },
                    child: Text(
                      'Reduce Water',
                      style: TextStyle(color: const Color(0xFF171433), fontSize: 16.sp, fontWeight: FontWeight.w500),
                    )),
              ),
            ],
          ),
        ),
      ),
      title: 'Water',
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
                      children: [SvgPicture.asset("assets/icons/buble.svg"), Text(widget.label, style: TextStyle(fontSize: 20.sp, color: Colors.white, fontWeight: FontWeight.w600))],
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
