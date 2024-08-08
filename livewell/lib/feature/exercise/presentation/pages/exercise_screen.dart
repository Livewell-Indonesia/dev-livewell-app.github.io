import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/helper/tracker/livewell_tracker.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/exercise/presentation/controller/exercise_controller.dart';
import 'package:livewell/feature/exercise/presentation/pages/exercise_diary_screen.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/popup_asset/popup_asset_widget.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';
import 'package:livewell/widgets/textfield/livewell_textfield.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

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

  @override
  void initState() {
    controller.trackEvent(LivewellExerciseEvent.exercisePage);
    super.initState();
  }

  File? file;
  bool showShareSheet = false;

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
      title: controller.localization.exercise ?? "",
      backgroundColor: const Color(0xFFF1F1F1),
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Spacer(),
          InkWell(
            onTap: () async {
              controller.trackEvent(LivewellExerciseEvent.exercisePageShareButton);
              await showModalBottomSheet(
                  context: context,
                  shape: ShapeBorder.lerp(const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                      const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))), 1),
                  builder: (context) {
                    return ImagePickerBottomSheet(onImageSelected: (img, source) async {
                      if (source == ImageSource.camera) {
                        controller.trackEvent(LivewellExerciseEvent.exercisePageShareTakeAPhotoButton);
                      } else {
                        controller.trackEvent(LivewellExerciseEvent.exercisePageSharePickFromGalleryButton);
                      }
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
                    shape: ShapeBorder.lerp(const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                        const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))), 1),
                    builder: (context) {
                      return Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: SizedBox(
                          height: 0.45.sh,
                          child: Column(
                            children: [
                              20.verticalSpace,
                              Text(
                                'Share',
                                style: TextStyle(color: const Color(0xff171433), fontSize: 24.sp, fontWeight: FontWeight.w700),
                              ),
                              20.verticalSpace,
                              Obx(() {
                                return LiveWellTextField(
                                    controller: controller.titleController, hintText: null, labelText: "Activity Name", errorText: controller.titleError.value, obscureText: false);
                              }),
                              20.verticalSpace,
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: Get.context!,
                                      isScrollControlled: true,
                                      shape: ShapeBorder.lerp(const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                                          const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))), 1),
                                      builder: (BuildContext context) {
                                        return SizedBox(
                                          height: 0.8.sh,
                                          child: Column(
                                            children: [
                                              20.verticalSpace,
                                              Text(
                                                'Location',
                                                style: TextStyle(color: const Color(0xFF171433), fontSize: 24.sp, fontWeight: FontWeight.w600),
                                              ),
                                              20.verticalSpace,
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                                                child: GooglePlaceAutoCompleteTextField(
                                                  textEditingController: controller.locationController,
                                                  googleAPIKey: Platform.isAndroid ? "AIzaSyAyGPWBoAyXoiZPuOr1tVy_lhDbqiY6gVw" : "AIzaSyAxbnqu8icKNHauUZveyBjG5srd7f1GQIA",
                                                  textStyle: TextStyle(color: const Color(0xFF171433), fontSize: 14.sp),
                                                  boxDecoration: BoxDecoration(color: const Color(0xFFF2F6F6), borderRadius: BorderRadius.circular(100)),
                                                  inputDecoration: const InputDecoration(
                                                      icon: Icon(Icons.search), hintText: "Search here...", border: InputBorder.none, enabledBorder: InputBorder.none, focusedBorder: InputBorder.none),
                                                  debounceTime: 400,
                                                  countries: const ["id"],
                                                  isLatLngRequired: false,
                                                  itemBuilder: (context, index, prediction) {
                                                    return SizedBox(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            prediction.terms?.first.value ?? "",
                                                            textAlign: TextAlign.start,
                                                            style: TextStyle(color: const Color(0xFF505050), fontSize: 16.sp, fontWeight: FontWeight.w600),
                                                          ),
                                                          4.verticalSpace,
                                                          Text(
                                                            prediction.description ?? "",
                                                            textAlign: TextAlign.start,
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(color: const Color(0xFF808080), fontSize: 12.sp),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  itemClick: (prediction) {
                                                    if (prediction.terms != null && prediction.terms!.isNotEmpty) {
                                                      controller.locationController.text = prediction.terms!.first.value ?? "";
                                                      Navigator.of(context).pop();
                                                    }
                                                  },
                                                  seperatedBuilder: 20.verticalSpace,
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: LiveWellTextField(controller: controller.locationController, hintText: null, labelText: "Location Name", errorText: null, enabled: false, obscureText: false),
                              ),
                              20.verticalSpace,
                              Text(
                                'Pick an Image Ratio:',
                                style: TextStyle(color: const Color(0xff171433), fontSize: 24.sp, fontWeight: FontWeight.w700),
                              ),
                              20.verticalSpace,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: LiveWellButton(
                                        onPressed: () {
                                          controller.trackEvent(LivewellExerciseEvent.exercisePageShare169RatioButton);
                                          if (controller.titleController.text.isNotEmpty) {
                                            Get.back();
                                            _showFullScreenDialog(context, file!, 9 / 16);
                                            // shareToInstagramStory(
                                            //     result);
                                          } else {
                                            controller.titleError.value = "Activity name is required";
                                          }
                                        },
                                        label: '16:9',
                                        color: const Color(0xFF8F01DF),
                                        textColor: Colors.white,
                                      ),
                                    ),
                                    20.horizontalSpace,
                                    Expanded(
                                      child: LiveWellButton(
                                        onPressed: () {
                                          controller.trackEvent(LivewellExerciseEvent.exercisePageShare11RatioButton);
                                          if (controller.titleController.text.isNotEmpty) {
                                            Get.back();
                                            _showFullScreenDialog(context, file!, 1);
                                          } else {
                                            controller.titleError.value = "Activity name is required";
                                          }
                                        },
                                        label: '1:1',
                                        color: const Color(0xFF8F01DF),
                                        textColor: Colors.white,
                                      ),
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
            child: Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: const Icon(
                Icons.ios_share,
                color: Color(0xFF171433),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              HomeController controller = Get.find();
              controller.trackEvent(LivewellExerciseEvent.exercisePageShareButton);
              var data = controller.popupAssetsModel.value.exercise;
              if (data != null) {
                showModalBottomSheet<dynamic>(
                    context: context,
                    isScrollControlled: true,
                    shape: ShapeBorder.lerp(const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                        const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))), 1),
                    builder: (context) {
                      return Obx(() {
                        return PopupAssetWidget(
                          exercise: controller.popupAssetsModel.value.exercise!,
                        );
                      });
                    });
              }
            },
            child: const Icon(
              Icons.info_outline,
              color: Color(0xFF171433),
            ),
          ),
        ],
      ),
      // resizeToAvoidBottomInset: true,
      body: Expanded(
        child: RefreshIndicator(
          onRefresh: () async {
            Get.snackbar("Health Data Syncing", "Health data syncing may take some time. We appreciate your patience!", duration: const Duration(seconds: 7));
            controller.refreshList();
          },
          child: ListView(
            children: [
              40.verticalSpace,
              ExerciseDiaryScreen(),
              32.verticalSpace,
              LiveWellButton(
                label: 'Input Steps',
                color: const Color(0xFF8F01DF),
                textColor: Colors.white,
                onPressed: () {
                  controller.trackEvent(LivewellExerciseEvent.exercisePageInputStepsButton);
                  AppNavigator.push(routeName: AppPages.manualInputExercise);
                },
              ),
              32.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  controller.localization.exerciseHabit!,
                  style: TextStyle(color: const Color(0xFF171433), fontSize: 20.sp, fontWeight: FontWeight.w600),
                ),
              ),
              16.verticalSpace,
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFEBEBEB))),
                child: Column(
                  children: [
                    Text(controller.localization.last7Days!, style: TextStyle(color: Colors.black, fontSize: 14.sp, fontWeight: FontWeight.w700, height: 20.sp / 14.sp)),
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
                                      BarChartRodData(color: controller.isYValueOptimal(index) ? const Color(0xFFDDF235) : const Color(0xFFFA6F6F), width: 12.w, toY: controller.getYValue(index))
                                    ],
                                  );
                                }),
                                barTouchData: BarTouchData(
                                  enabled: true,
                                  touchTooltipData: BarTouchTooltipData(
                                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                      return BarTooltipItem(
                                        '${NumberFormat('0.0').format(rod.toY)} kcal',
                                        TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14.sp),
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
                                      return FlLine(color: const Color(0xFFebebeb), strokeWidth: 1, dashArray: [2, 2]);
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
                                          style: TextStyle(color: const Color(0xFF505050), fontSize: 12.sp),
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
                                            padding: const EdgeInsets.only(top: 10),
                                            child: Text(
                                              controller.getXValue(value.toInt()),
                                              style: TextStyle(color: const Color(0xFF505050), fontSize: 12.sp),
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
                                style: TextStyle(color: const Color(0xFF505050), fontSize: 10.sp, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      );
                    })
                  ],
                ),
              ),
              40.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  _showFullScreenDialog(BuildContext context, File file, double aspectRatio) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Obx(() {
            return ExerciseSharePage(
                file: file,
                title: controller.titleController.text,
                steps: controller.steps.value.round().toInt(),
                calories: controller.burntCalories.round().toInt(),
                distance: controller.calculateDistance(controller.steps.value.round().toInt(), 0.76),
                location: controller.locationController.text,
                aspectRatio: aspectRatio);
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
      {super.key,
      required this.file,
      required this.overlayText,
      required this.aspectRatio,
      required this.title,
      required this.steps,
      required this.distance,
      required this.calories,
      required this.location});

  var myGroup = AutoSizeGroup();

  // ... existing code ...

  @override
  Widget build(BuildContext context) {
    // ... existing code ...

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
          Positioned.fill(
              top: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/images/IMG_5451.png"), fit: BoxFit.cover),
                        ),
                        padding: EdgeInsets.only(left: 16.w, right: 62.w, top: 64.h, bottom: 25.h),
                        margin: EdgeInsets.only(right: 40.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month,
                                  color: Color(0xFF8F01DF),
                                  size: 16,
                                ),
                                Expanded(
                                  child: AutoSizeText(
                                    DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now()),
                                    maxLines: 1,
                                    style: TextStyle(color: const Color(0xFF8F01DF), fontSize: 10.sp),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Color(0xFF8F01DF),
                                  size: 16,
                                ),
                                Flexible(
                                  child: Text(
                                    location,
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(color: const Color(0xFF8F01DF), fontSize: 10.sp),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                                color: const Color(0xFF8F01DF),
                              ),
                            ),
                            2.verticalSpace,
                            const Divider(
                              height: 4,
                              color: Color(0xFF8F01DF),
                            ),
                            2.verticalSpace,
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    "Steps",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      color: const Color(0xFF8F01DF),
                                    ),
                                  ),
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    "$steps",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12.sp,
                                      color: const Color(0xFF8F01DF),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            2.verticalSpace,
                            Row(
                              children: [
                                Text(
                                  "Distance",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp,
                                    color: const Color(0xFF8F01DF),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    "${NumberFormat("0.0").format(distance)} KM",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12.sp,
                                      color: const Color(0xFF8F01DF),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            2.verticalSpace,
                            Row(
                              children: [
                                Text(
                                  "Calories burnt",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp,
                                    color: const Color(0xFF8F01DF),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    "$calories kcal",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12.sp,
                                      color: const Color(0xFF8F01DF),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ],
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
    Log.error('Error sharing to Instagram: $e');
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
