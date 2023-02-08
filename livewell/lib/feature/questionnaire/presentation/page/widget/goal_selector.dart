import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/questionnaire_controller.dart';

class GoalSelector extends StatelessWidget {
  final QuestionnaireController controller = Get.find();
  GoalSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 298.h,
      child: ListView.separated(
        itemBuilder: (context, index) {
          // create button with rounded corner and border if selected, change color to purple
          if (GoalSelection.none == GoalSelection.values[index]) {
            return Container();
          } else {
            return Obx(() {
              return controller.selectedGoals.value !=
                      GoalSelection.values[index]
                  ? Center(
                      child: InkWell(
                        onTap: () {
                          controller.selectedGoals.value =
                              GoalSelection.values[index];
                        },
                        child: Text(
                          GoalSelection.values[index].title(),
                          style: TextStyle(
                              fontSize: 18,
                              color: const Color(0xFF171433).withOpacity(0.7)),
                        ),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 19).r,
                      height: 57.h,
                      child: ElevatedButton(
                          onPressed: () {
                            controller.selectedGoals.value =
                                GoalSelection.values[index];
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  side: BorderSide(
                                      color: const Color(0xFF8F01DF),
                                      width: 3.w))),
                          child: Obx(() {
                            return Text(
                              GoalSelection.values[index].title(),
                              style: TextStyle(
                                  color: controller.selectedGoals.value ==
                                          GoalSelection.values[index]
                                      ? const Color(0xFF8F01DF)
                                      : const Color(0xFF171433)
                                          .withOpacity(0.7),
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w600),
                            );
                          })),
                    );
            });
          }
        },
        itemCount: GoalSelection.values.length,
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 20,
          );
        },
      ),
    );
  }
}
