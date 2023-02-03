import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/exercise/presentation/controller/exercise_controller.dart';
import 'package:livewell/feature/exercise/presentation/pages/exercise_diary_screen.dart';

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
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            57.verticalSpace,
            Center(
                child: Text(
              "Exercise",
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF171433)),
            )),
            38.verticalSpace,
            // Obx(() {
            //   return SlideSwitcher(
            //     containerColor: Colors.white,
            //     onSelect: (int index) {
            //       controller.changeTab(ExerciseTab.values[index]);
            //     },
            //     valueNotifier: controller.sliderValueNotifier,
            //     containerHeight: 35,
            //     containerWight: 200,
            //     slidersColors: const [
            //       Color(0xFFDDF235),
            //     ],
            //     children: [
            //       Text(
            //         'Diary',
            //         style: TextStyle(
            //           fontWeight: FontWeight.w600,
            //           color: controller.currentMenu.value.index == 0
            //               ? const Color(0xFF171433)
            //               : const Color(0xFF171433).withOpacity(0.3),
            //         ),
            //       ),
            //       Text(
            //         'Classes',
            //         style: TextStyle(
            //           fontWeight: FontWeight.w600,
            //           color: controller.currentMenu.value.index == 1
            //               ? const Color(0xFF171433)
            //               : const Color(0xFF171433).withOpacity(0.3),
            //         ),
            //       ),
            //     ],
            //   );
            // }),
            //40.verticalSpace,
            const ExerciseDiaryScreen(),
            // Expanded(
            //   child:
            //       TabBarView(controller: controller.tabController, children: [
            //     ExerciseDiaryScreen(),
            //     const ExerciseClassScreen(),
            //   ]),
            // )
          ],
        ),
      ),
    );
  }
}
