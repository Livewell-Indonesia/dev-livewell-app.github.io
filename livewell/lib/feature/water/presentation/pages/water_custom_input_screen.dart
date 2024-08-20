import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/feature/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:livewell/feature/diary/presentation/page/user_diary_screen.dart';
import 'package:livewell/feature/streak/presentation/pages/streak_screen.dart';
import 'package:livewell/feature/water/presentation/controller/water_controller.dart';
import 'package:livewell/feature/water/presentation/controller/water_custom_input_controller.dart';
import 'package:livewell/feature/water/presentation/enum/water_input_type.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/theme/design_system.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';

class WaterCustomInputScreen extends StatefulWidget {
  const WaterCustomInputScreen({super.key});

  @override
  State<WaterCustomInputScreen> createState() => _WaterCustomInputScreenState();
}

class _WaterCustomInputScreenState extends State<WaterCustomInputScreen> {
  var controller = Get.put(WaterCustomInputController());
  final GlobalKey _containerKey = GlobalKey();
  final GlobalKey _bottleKey = GlobalKey();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return LiveWellScaffold(
          title: controller.type.value.navbarTitle,
          body: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 60.h),
                        child: ClipPath(
                          clipBehavior: Clip.hardEdge,
                          clipper: LivewellBottleClipper(),
                          child: Stack(
                            children: [
                              Container(
                                width: 258.h,
                                height: 412.h,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Container(
                                      width: 258.h,
                                      height: 412.h,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF8F01DF),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                key: _bottleKey,
                                width: 258.h,
                                height: 412.h,
                                color: Colors.white,
                                alignment: Alignment.bottomCenter,
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    controller.currentValue.value != 0
                                        ? Positioned(
                                            bottom: 412.h / (controller.maxMils / controller.currentValue.value) - 2.h,
                                            child: SizedBox(
                                              width: 1.sw,
                                              height: 2.h,
                                              // decoration: const BoxDecoration(
                                              //   color: Color(0xFF8F01DF),
                                              // ),
                                              child: ListView.separated(
                                                  scrollDirection: Axis.horizontal,
                                                  itemBuilder: (context, index) {
                                                    return Container(
                                                      width: 5.w,
                                                      height: 2.h,
                                                      color: const Color(0xFF8F01DF),
                                                    );
                                                  },
                                                  separatorBuilder: (context, index) {
                                                    return SizedBox(
                                                      width: 5.w,
                                                    );
                                                  },
                                                  itemCount: 412.h ~/ 5.h),
                                            ),
                                          )
                                        : const SizedBox(),
                                    calculatePercentage(controller.position.value) != 0
                                        ? LiquidLinearProgressIndicator(
                                            backgroundColor: Colors.transparent,
                                            direction: Axis.vertical,
                                            value: calculatePercentage(controller.position.value).maxOneOrZero == 0
                                                ? -1
                                                : calculatePercentage(controller.position.value).maxOneOrZero == 1
                                                    ? 1.1
                                                    : calculatePercentage(controller.position.value).maxOneOrZero,
                                            valueColor: const AlwaysStoppedAnimation(Color(0xFF34EAB2)),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: controller.position.value,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onVerticalDragUpdate: (details) {
                            var renderBox = _bottleKey.currentContext!.findRenderObject() as RenderBox;
                            var positions = renderBox.localToGlobal(Offset.zero);
                            var bottleTop = positions.dy;
                            var bottleBottom = positions.dy + 412.h;
                            //Log.colorGreen('maxTop: $maxTop maxBottom: $maxBottom ${details.globalPosition.dy} bottleTop: $bottleTop bottleBottom: $bottleBottom , ${412.h}');
                            setState(() {
                              if (details.globalPosition.dy < bottleBottom + 12.h && details.globalPosition.dy >= 0 && details.globalPosition.dy >= bottleTop + 12.h) {
                                if (controller.currentValue.value != 0) {
                                  if ((bottleBottom - details.globalPosition.dy).h < 412.h / (controller.maxMils.value / controller.currentValue.value)) {
                                    if ((bottleBottom - details.globalPosition.dy).h < 412.h / (controller.maxMils.value / controller.minimumReduce.value)) {
                                      controller.position.value = 412.h / (controller.maxMils.value / controller.minimumReduce.value);
                                    } else {
                                      controller.position.value = (bottleBottom - details.globalPosition.dy).h;
                                    }
                                  } else if ((bottleBottom - details.globalPosition.dy).h > 412.h / (controller.maxMils.value / controller.currentValue.value)) {
                                    controller.position.value = 412.h / (controller.maxMils.value / controller.currentValue.value);
                                  }
                                } else {
                                  controller.position.value = (bottleBottom - details.globalPosition.dy).h;
                                }

                                //Log.colorGreen('position: $position');
                              }
                            });
                          },
                          // child: Container(
                          //   width: 1.sw,
                          //   height: 20.h,
                          //   color: Colors.red,
                          // ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 30.h),
                            child: Container(
                              key: _containerKey,
                              width: 60.w,
                              height: 60.h,
                              decoration: const BoxDecoration(
                                color: Color(0xFF8F01DF),
                                shape: BoxShape.circle,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.keyboard_arrow_up,
                                    color: Colors.white,
                                    size: 24.sp,
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                    size: 24.sp,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${(calculatePercentage(controller.position.value).maxOneOrZero * controller.maxMils.value).toInt()} ml',
                        style: TextStyle(color: Theme.of(context).colorScheme.textHiEm, fontSize: 32.sp, fontWeight: FontWeight.w600)),
                    8.horizontalSpace,
                    InkWell(
                        onTap: () {
                          focusNode.requestFocus();
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: shapeBorder(),
                              builder: (context) {
                                return Wrap(
                                  children: [
                                    Container(
                                      width: 1.sw,
                                      padding: MediaQuery.of(context).viewInsets,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(32),
                                          topRight: Radius.circular(32),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                                        child: Column(
                                          children: [
                                            24.verticalSpace,
                                            Text(
                                              controller.localization.waterPage?.inputYourWaterIntake ?? 'Input your water intake',
                                              style: TextStyle(color: Theme.of(context).colorScheme.textLoEm, fontWeight: FontWeight.w600, fontSize: 16.sp),
                                            ),
                                            Obx(() {
                                              if (controller.type.value == WaterInputType.reduce) {
                                                return Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    8.verticalSpace,
                                                    RichText(
                                                      textAlign: TextAlign.center,
                                                      text: TextSpan(
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text: controller.localization.waterPage?.pleaseReduceYourWaterIntakeByUpTo ?? 'Please reduce your water intake by up to ',
                                                            style: TextStyle(color: Theme.of(context).colorScheme.neutral90, fontSize: 12.sp, fontWeight: FontWeight.w400),
                                                          ),
                                                          TextSpan(
                                                            text: '${controller.currentValue.value} ml',
                                                            style: TextStyle(color: Theme.of(context).colorScheme.neutral90, fontSize: 12.sp, fontWeight: FontWeight.w700),
                                                          ),
                                                          TextSpan(
                                                            text: controller.localization.waterPage?.totalOfWaterYouHaveAlreadyLogged ?? ' (total of water you have already logged).',
                                                            style: TextStyle(color: Theme.of(context).colorScheme.neutral90, fontSize: 12.sp, fontWeight: FontWeight.w400),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              } else {
                                                return const SizedBox();
                                              }
                                            }),
                                            16.verticalSpace,
                                            Visibility(
                                              visible: false,
                                              maintainState: true,
                                              child: TextField(
                                                canRequestFocus: true,
                                                autofocus: true,
                                                showCursor: false,
                                                decoration: InputDecoration(
                                                  hintStyle: TextStyle(color: Theme.of(context).colorScheme.neutral90, fontSize: 12.sp, fontWeight: FontWeight.w400),
                                                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(8),
                                                    borderSide: const BorderSide(color: Colors.transparent),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(8),
                                                    borderSide: const BorderSide(color: Colors.transparent),
                                                  ),
                                                ),
                                                keyboardType: TextInputType.number,
                                                onChanged: (value) {
                                                  if (value.isNotEmpty) {
                                                    controller.inputtedValue.value = int.parse(value);
                                                  } else {
                                                    controller.inputtedValue.value = 0;
                                                  }
                                                  //controller.currentValue.value = int.parse(value);
                                                },
                                              ),
                                            ),
                                            Obx(() {
                                              return Text(controller.inputtedValue.value.toString(),
                                                  style: TextStyle(color: Theme.of(context).colorScheme.textHiEm, fontWeight: FontWeight.w600, fontSize: 32.sp));
                                            }),
                                            Obx(() {
                                              if (controller.inputtedValue.value > controller.maxMils.value ||
                                                  (controller.inputtedValue.value > controller.currentValue.value && controller.type.value == WaterInputType.reduce)) {
                                                return Text(
                                                  '${controller.localization.waterPage?.pleaseKeepYourWaterIntakeUnder ?? 'Please keep your input under'} ${controller.type.value == WaterInputType.increase ? controller.maxMils.value : controller.currentValue.value} ml',
                                                  style: TextStyle(color: Theme.of(context).colorScheme.dangerMain, fontWeight: FontWeight.w600, fontSize: 12.sp),
                                                );
                                              } else {
                                                return const SizedBox();
                                              }
                                            }),
                                            16.verticalSpace,
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 80.w),
                                              child: Obx(
                                                () {
                                                  return LiveWellButton(
                                                    label: controller.type.value.buttonText,
                                                    textColor: Colors.white,
                                                    color: Theme.of(context).colorScheme.primaryPurple,
                                                    onPressed: controller.inputtedValue.value > controller.maxMils.value ||
                                                            controller.inputtedValue.value == 0 ||
                                                            (controller.inputtedValue.value > controller.currentValue.value && controller.type.value == WaterInputType.reduce)
                                                        ? null
                                                        : () async {
                                                            if (controller.type.value == WaterInputType.increase) {
                                                              await SharedPref.saveLastCustomWaterInput(controller.inputtedValue.value);
                                                            }
                                                            Get.find<WaterController>()
                                                                .addWater(controller.type.value == WaterInputType.increase ? controller.inputtedValue.value : -controller.inputtedValue.value);
                                                            AppNavigator.pop();
                                                            AppNavigator.pop();
                                                          },
                                                  );
                                                },
                                              ),
                                            ),
                                            16.verticalSpace,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).whenComplete(() {
                            controller.inputtedValue.value = 0;
                          });
                          // setState(() {
                          //   controller.position.value = 412.h / (controller.maxMils.value / 2000);
                          // });
                        },
                        child: SvgPicture.asset('assets/icons/ic_custom_input_water.svg'))
                  ],
                ),
                controller.type.value == WaterInputType.reduce
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.w),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: controller.localization.waterPage?.pleaseReduceYourWaterIntakeByUpTo ?? 'Please reduce your water intake by up to ',
                                style: TextStyle(color: Theme.of(context).colorScheme.neutral90, fontSize: 12.sp, fontWeight: FontWeight.w400),
                              ),
                              TextSpan(
                                text: '${controller.currentValue.value} ml',
                                style: TextStyle(color: Theme.of(context).colorScheme.neutral90, fontSize: 12.sp, fontWeight: FontWeight.w700),
                              ),
                              TextSpan(
                                text: controller.localization.waterPage?.totalOfWaterYouHaveAlreadyLogged ?? ' (total of water you have already logged).',
                                style: TextStyle(color: Theme.of(context).colorScheme.neutral90, fontSize: 12.sp, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(),
                24.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100.w),
                  child: LiveWellButton(
                    label: controller.type.value.buttonText,
                    color: Theme.of(context).colorScheme.primaryPurple,
                    onPressed: (calculatePercentage(controller.position.value).maxOneOrZero * controller.maxMils.value).toInt() == 0
                        ? null
                        : () async {
                            if (controller.type.value == WaterInputType.increase) {
                              await SharedPref.saveLastCustomWaterInput((calculatePercentage(controller.position.value).maxOneOrZero * controller.maxMils.value).toInt());
                            }
                            var value = (calculatePercentage(controller.position.value).maxOneOrZero * controller.maxMils.value).toInt();
                            Get.find<WaterController>().addWater(controller.type.value == WaterInputType.increase ? value : -value);
                            Get.back();
                          },
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ));
    });
  }

  double calculatePercentage(double x) {
    double xMin = 0;
    double xMax = 412.h;
    double range = xMax - xMin;
    double difference = x - xMin;
    double percentage = (difference / range) * 100;
    return percentage / 100;
  }
}
