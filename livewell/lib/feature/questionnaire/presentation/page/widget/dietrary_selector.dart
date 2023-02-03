import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/questionnaire/presentation/controller/questionnaire_controller.dart';

class DietrarySelector extends StatelessWidget {
  final QuestionnaireController controller = Get.find();
  DietrarySelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 298.h,
      child: ListView.separated(
        itemBuilder: (context, index) {
          if (DietrarySelection.none == DietrarySelection.values[index]) {
            return Container();
          } else {
            return Obx(() {
              return controller.selectedDietrary.value !=
                      DietrarySelection.values[index]
                  ? Center(
                      child: InkWell(
                        onTap: () {
                          controller.selectedDietrary.value =
                              DietrarySelection.values[index];
                          controller.selectedDietraryText.text =
                              DietrarySelection.values[index].name;
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            DietrarySelection.values[index].title(),
                            style: TextStyle(
                                fontSize: 18,
                                color:
                                    const Color(0xFF171433).withOpacity(0.7)),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 19).r,
                      height: 57.h,
                      child: controller.selectedDietrary.value ==
                              DietrarySelection.yes
                          ? Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFF8F01DF), width: 2),
                                  borderRadius: BorderRadius.circular(36)),
                              child: TextField(
                                controller: controller.selectedDietraryText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 24.sp,
                                    color: const Color(0xFF8F01DF),
                                    fontWeight: FontWeight.w600),
                                cursorColor: const Color(0xFF8F01DF),
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                controller.selectedDietrary.value =
                                    DietrarySelection.values[index];
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
                                  DietrarySelection.values[index].title(),
                                  style: TextStyle(
                                      color: controller
                                                  .selectedDietrary.value ==
                                              DietrarySelection.values[index]
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
        itemCount: DietrarySelection.values.length,
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 20,
          );
        },
      ),
    );
  }
}
