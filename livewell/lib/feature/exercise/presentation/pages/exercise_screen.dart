import 'dart:developer';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:davinci/davinci.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/feature/exercise/presentation/controller/exercise_controller.dart';
import 'package:livewell/feature/exercise/presentation/pages/exercise_diary_screen.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/widgets/popup_asset/popup_asset_widget.dart';
import 'package:livewell/widgets/textfield/livewell_textfield.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:ui' as ui;

import '../../../profile/presentation/page/user_settings_screen.dart';
import 'exercise_share_page.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  int switcherIndex2 = 0;

  ExerciseController controller = Get.put(ExerciseController());

  final GlobalKey _key1 = GlobalKey();
  File? file;
  bool showShareSheet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      resizeToAvoidBottomInset: true,
      body: RefreshIndicator(
        onRefresh: () async {
          controller.refreshList();
        },
        child: ListView(
          children: [
            40.verticalSpace,
            Row(
              children: [
                const Icon(
                  Icons.ios_share,
                  color: Colors.transparent,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: const Icon(
                    Icons.info_outline,
                    color: Colors.transparent,
                  ),
                ),
                const Spacer(),
                Center(
                    child: Text(
                  controller.localization.exercise!,
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF171433)),
                )),
                const Spacer(),
                InkWell(
                  onTap: () async {
                    await showModalBottomSheet(
                        context: context,
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
                        builder: (context) {
                          return ImagePickerBottomSheet(
                              onImageSelected: (img) async {
                            setState(() {
                              file = img;
                            });
                            Navigator.of(context).pop();
                          });
                        });

                    if (file != null) {
                      await showModalBottomSheet(
                          context: Get.context!,
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
                          builder: (context) {
                            return Padding(
                              padding: MediaQuery.of(context).viewInsets,
                              child: Container(
                                height: 0.45.sh,
                                child: Column(
                                  children: [
                                    20.verticalSpace,
                                    Text(
                                      'Share',
                                      style: TextStyle(
                                          color: Color(0xff171433),
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    20.verticalSpace,
                                    Obx(() {
                                      return LiveWellTextField(
                                          controller:
                                              controller.titleController,
                                          hintText: null,
                                          labelText: "Activity Name",
                                          errorText:
                                              controller.titleError.value,
                                          obscureText: false);
                                    }),
                                    20.verticalSpace,
                                    InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: Get.context!,
                                            isScrollControlled: true,
                                            shape: ShapeBorder.lerp(
                                                const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    20),
                                                            topRight:
                                                                Radius.circular(
                                                                    20))),
                                                const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    20),
                                                            topRight:
                                                                Radius.circular(
                                                                    20))),
                                                1),
                                            builder: (BuildContext context) {
                                              return Container(
                                                height: 0.8.sh,
                                                child: Column(
                                                  children: [
                                                    20.verticalSpace,
                                                    Text(
                                                      'Location',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF171433),
                                                          fontSize: 24.sp,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    20.verticalSpace,
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 16.w,
                                                              vertical: 16.h),
                                                      child:
                                                          GooglePlaceAutoCompleteTextField(
                                                        textEditingController:
                                                            controller
                                                                .locationController,
                                                        googleAPIKey: Platform
                                                                .isAndroid
                                                            ? "AIzaSyAyGPWBoAyXoiZPuOr1tVy_lhDbqiY6gVw"
                                                            : "AIzaSyAxbnqu8icKNHauUZveyBjG5srd7f1GQIA",
                                                        textStyle: TextStyle(
                                                            color: const Color(
                                                                0xFF171433),
                                                            fontSize: 14.sp),
                                                        boxDecoration: BoxDecoration(
                                                            color: const Color(
                                                                0xFFF2F6F6),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100)),
                                                        inputDecoration:
                                                            const InputDecoration(
                                                                icon: Icon(Icons
                                                                    .search),
                                                                hintText:
                                                                    "Search here...",
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                enabledBorder:
                                                                    InputBorder
                                                                        .none,
                                                                focusedBorder:
                                                                    InputBorder
                                                                        .none),
                                                        debounceTime: 400,
                                                        countries: ["id"],
                                                        isLatLngRequired: false,
                                                        itemBuilder: (context,
                                                            index, prediction) {
                                                          return Container(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  prediction
                                                                          .terms
                                                                          ?.first
                                                                          .value ??
                                                                      "",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: TextStyle(
                                                                      color: const Color(
                                                                          0xFF505050),
                                                                      fontSize:
                                                                          16.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                4.verticalSpace,
                                                                Text(
                                                                  prediction
                                                                          .description ??
                                                                      "",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      color: const Color(
                                                                          0xFF808080),
                                                                      fontSize:
                                                                          12.sp),
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                        itemClick:
                                                            (prediction) {
                                                          if (prediction
                                                                      .terms !=
                                                                  null &&
                                                              prediction.terms!
                                                                  .isNotEmpty) {
                                                            controller
                                                                .locationController
                                                                .text = prediction
                                                                    .terms!
                                                                    .first
                                                                    .value ??
                                                                "";
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          }
                                                        },
                                                        seperatedBuilder:
                                                            20.verticalSpace,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      child: LiveWellTextField(
                                          controller:
                                              controller.locationController,
                                          hintText: null,
                                          labelText: "Location Name",
                                          errorText: null,
                                          enabled: false,
                                          obscureText: false),
                                    ),
                                    20.verticalSpace,
                                    Text(
                                      'Pick an Image Ratio:',
                                      style: TextStyle(
                                          color: Color(0xff171433),
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    20.verticalSpace,
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                                onPressed: () async {
                                                  if (controller.titleController
                                                      .text.isNotEmpty) {
                                                    EasyLoading.show();
                                                    final result =
                                                        await DavinciCapture.offStage(
                                                            context: Get
                                                                .context!,
                                                            Obx(() {
                                                      return ImageWithOverlay(
                                                          file: file!,
                                                          overlayText: "andi",
                                                          title: controller
                                                              .titleController
                                                              .text,
                                                          steps: controller
                                                              .steps.value
                                                              .round()
                                                              .toInt(),
                                                          calories: controller
                                                              .burntCalories
                                                              .round()
                                                              .toInt(),
                                                          distance: controller
                                                              .calculateDistance(
                                                                  controller
                                                                      .steps
                                                                      .value
                                                                      .round()
                                                                      .toInt(),
                                                                  0.76),
                                                          location: controller
                                                              .locationController
                                                              .text,
                                                          aspectRatio: 9 / 16);
                                                    }),
                                                            returnImageUint8List:
                                                                true,
                                                            openFilePreview:
                                                                false,
                                                            pixelRatio: Get
                                                                .pixelRatio,
                                                            wait:
                                                                const Duration(
                                                                    seconds:
                                                                        2));
                                                    controller.titleError
                                                        .value = null;
                                                    EasyLoading.dismiss();
                                                    Get.back();
                                                    _showFullScreenDialog(
                                                        context, file!);
                                                    // shareToInstagramStory(
                                                    //     result);
                                                  } else {
                                                    controller
                                                            .titleError.value =
                                                        "Activity name is required";
                                                  }
                                                },
                                                child: const Text('16:9')),
                                          ),
                                          20.horizontalSpace,
                                          Expanded(
                                            child: ElevatedButton(
                                                onPressed: () async {
                                                  if (controller.titleController
                                                      .text.isNotEmpty) {
                                                    EasyLoading.show();
                                                    final result =
                                                        await DavinciCapture.offStage(
                                                            context: Get
                                                                .context!,
                                                            Obx(() {
                                                      return ImageWithOverlay(
                                                          file: file!,
                                                          overlayText: "andi",
                                                          title: controller
                                                              .titleController
                                                              .text,
                                                          steps: controller
                                                              .steps.value
                                                              .round()
                                                              .toInt(),
                                                          calories: controller
                                                              .burntCalories
                                                              .round()
                                                              .toInt(),
                                                          distance: controller
                                                              .calculateDistance(
                                                                  controller
                                                                      .steps
                                                                      .value
                                                                      .round()
                                                                      .toInt(),
                                                                  0.76),
                                                          location: controller
                                                              .locationController
                                                              .text,
                                                          aspectRatio: 1);
                                                    }),
                                                            returnImageUint8List:
                                                                true,
                                                            openFilePreview:
                                                                false,
                                                            pixelRatio: Get
                                                                .pixelRatio,
                                                            wait:
                                                                const Duration(
                                                                    seconds:
                                                                        2));
                                                    controller.titleError
                                                        .value = null;
                                                    EasyLoading.dismiss();
                                                    shareToInstagramStory(
                                                        result);
                                                  } else {
                                                    controller
                                                            .titleError.value =
                                                        "Activity name is required";
                                                  }
                                                },
                                                child: const Text('1:1')),
                                          ),
                                        ],
                                      ),
                                    ),
                                    30.verticalSpace,
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  },
                  child: const Icon(
                    Icons.ios_share,
                    color: Color(0xFF171433),
                  ),
                ),
                InkWell(
                  onTap: () {
                    HomeController controller = Get.find();
                    var data = controller.popupAssetsModel.value.exercise;
                    if (data != null) {
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
                          builder: (context) {
                            return Obx(() {
                              return PopupAssetWidget(
                                exercise:
                                    controller.popupAssetsModel.value.exercise!,
                              );
                            });
                          });
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: const Icon(
                      Icons.info_outline,
                      color: Color(0xFF171433),
                    ),
                  ),
                ),
              ],
            ),
            38.verticalSpace,
            const ExerciseDiaryScreen(),
            32.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                controller.localization.exerciseHabit!,
                style: TextStyle(
                    color: const Color(0xFF171433),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
            16.verticalSpace,
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFEBEBEB))),
              child: Column(
                children: [
                  Text(controller.localization.last7Days!,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          height: 20.sp / 14.sp)),
                  16.verticalSpace,
                  const Divider(),
                  16.verticalSpace,
                  Obx(() {
                    return SizedBox(
                      height: 200.h,
                      child: Stack(
                        children: [
                          BarChart(
                            BarChartData(
                              minY: 0,
                              barGroups: List.generate(7, (index) {
                                return BarChartGroupData(
                                  x: index,
                                  barRods: [
                                    BarChartRodData(
                                        color: controller.isYValueOptimal(index)
                                            ? const Color(0xFFDDF235)
                                            : const Color(0xFFFA6F6F),
                                        width: 12.w,
                                        toY: controller.getYValue(index))
                                  ],
                                );
                              }),
                              barTouchData: BarTouchData(
                                enabled: true,
                                touchTooltipData: BarTouchTooltipData(
                                  getTooltipItem:
                                      (group, groupIndex, rod, rodIndex) {
                                    return BarTooltipItem(
                                      '${NumberFormat('0.0').format(rod.toY)} kcal',
                                      TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.sp),
                                    );
                                  },
                                ),
                              ),
                              borderData: FlBorderData(show: false),
                              gridData: FlGridData(
                                  show: true,
                                  drawVerticalLine: false,
                                  horizontalInterval: 50,
                                  getDrawingHorizontalLine: (value) {
                                    return FlLine(
                                        color: const Color(0xFFebebeb),
                                        strokeWidth: 1,
                                        dashArray: [2, 2]);
                                  }),
                              titlesData: FlTitlesData(
                                show: true,
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    reservedSize: 30,
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.toInt().toString(),
                                        style: TextStyle(
                                            color: const Color(0xFF505050),
                                            fontSize: 12.sp),
                                      );
                                    },
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      return Transform.rotate(
                                        angle: -45,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Text(
                                            controller.getXValue(value.toInt()),
                                            style: TextStyle(
                                                color: const Color(0xFF505050),
                                                fontSize: 12.sp),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'kcal.',
                              style: TextStyle(
                                  color: const Color(0xFF505050),
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    );
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showFullScreenDialog(BuildContext context, File file) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Obx(() {
            return ExerciseSharePage(
                file: file,
                title: controller.titleController.text,
                steps: controller.steps.value.round().toInt(),
                calories: controller.burntCalories.round().toInt(),
                distance: controller.calculateDistance(
                    controller.steps.value.round().toInt(), 0.76),
                location: controller.locationController.text,
                aspectRatio: 9 / 16);
          });
        });
  }
}

class ImageWithOverlay extends StatelessWidget {
  final File file;
  final String overlayText;
  final double aspectRatio;
  final String title;
  final int steps;
  final double distance;
  final int calories;
  final String location;

  ImageWithOverlay(
      {required this.file,
      required this.overlayText,
      required this.aspectRatio,
      required this.title,
      required this.steps,
      required this.distance,
      required this.calories,
      required this.location});

  Future<Uint8List> _captureWidgetToImage(GlobalKey key) async {
    try {
      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData!.buffer.asUint8List();
    } catch (e) {
      print(e);
      return Uint8List(0);
    }
  }

  var myGroup = AutoSizeGroup();

  // ... existing code ...

  @override
  Widget build(BuildContext context) {
    // ... existing code ...

    return RepaintBoundary(
      key: key,
      child: Container(
        width: aspectRatio == 1 ? 1.sw : 295.w,
        height: aspectRatio == 1 ? 1.sw : 524.h,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.file(
              file,
              fit: BoxFit.cover,
            ),
            Positioned.fill(
                top: 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: SvgPicture.asset(
                        "assets/images/FA_Livewell_Logo_2.svg",
                        fit: BoxFit.cover,
                        color: const Color(0xFF8F01DF),
                        width: 112.w,
                        height: 30.h,
                      ),
                    ),
                    20.verticalSpace,
                    Container(
                      decoration: const BoxDecoration(
                          color: Color(0xFFDDF235),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(100),
                              bottomRight: Radius.circular(100))),
                      padding: EdgeInsets.only(
                          left: 20.w, right: 60.w, top: 20.h, bottom: 20.h),
                      margin: EdgeInsets.only(right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                color: Color(0xFF8F01DF),
                              ),
                              Expanded(
                                child: AutoSizeText(
                                  DateFormat('EEEE, dd MMMM yyyy')
                                      .format(DateTime.now()),
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Color(0xFF8F01DF),
                                      fontSize: 14.sp),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Color(0xFF8F01DF),
                              ),
                              Flexible(
                                child: Text(
                                  location,
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      color: Color(0xFF8F01DF),
                                      fontSize: 14.sp),
                                ),
                              ),
                            ],
                          ),
                          10.verticalSpace,
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 24.sp,
                              color: Color(0xFF8F01DF),
                            ),
                          ),
                          10.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      "$steps",
                                      maxLines: 1,
                                      group: myGroup,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20.sp,
                                        color: Color(0xFF8F01DF),
                                      ),
                                    ),
                                    Text(
                                      "steps",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp,
                                        color: Color(0xFF8F01DF),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      "${NumberFormat("0.0").format(distance)} KM",
                                      maxLines: 1,
                                      group: myGroup,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20.sp,
                                        color: Color(0xFF8F01DF),
                                      ),
                                    ),
                                    Text(
                                      "distance",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp,
                                        color: Color(0xFF8F01DF),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      "$calories kcal",
                                      maxLines: 1,
                                      group: myGroup,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20.sp,
                                        color: Color(0xFF8F01DF),
                                      ),
                                    ),
                                    Text(
                                      "calories burnt",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp,
                                        color: Color(0xFF8F01DF),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

Future<void> shareToInstagramStory(Uint8List imageBytes) async {
  try {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/livewell.jpg');
    await file.writeAsBytes(imageBytes);
    await Share.shareXFiles([XFile(file.path)]);
  } catch (e) {
    print('Error sharing to Instagram: $e');
  }
}

extension ContextExtensions on BuildContext {
  bool get mounted {
    try {
      widget;
      return true;
    } catch (e) {
      return false;
    }
  }
}
