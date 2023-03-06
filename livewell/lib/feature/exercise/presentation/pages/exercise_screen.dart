import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/exercise/presentation/controller/exercise_controller.dart';
import 'package:livewell/feature/exercise/presentation/pages/exercise_diary_screen.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/widgets/popup_asset/popup_asset_widget.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  int switcherIndex2 = 0;

  ExerciseController controller = Get.put(ExerciseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.refresh();
        },
        child: ListView(
          children: [
            40.verticalSpace,
            Row(
              children: [
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
                  "Exercise",
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF171433)),
                )),
                const Spacer(),
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
          ],
        ),
      ),
    );
  }
}
