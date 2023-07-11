import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/core/base/base_controller.dart';
import 'package:livewell/feature/questionnaire/presentation/controller/questionnaire_controller.dart';

class LanguageSelector extends StatelessWidget {
  final QuestionnaireController controller = Get.find();
  LanguageSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 298.h,
      child: ListView.separated(
        itemBuilder: (context, index) {
          // create button with rounded corner and border if selected, change color to purple
          return Obx(() {
            return controller.selectedLanguage.value !=
                    AvailableLanguage.values[index]
                ? Center(
                    child: InkWell(
                      onTap: () {
                        controller.selectedLanguage.value =
                            AvailableLanguage.values[index];
                        controller.changeLocalization(
                            AvailableLanguage.values[index]);
                      },
                      child: Text(
                        LanguageSelection.values[index].title(),
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
                          controller.selectedLanguage.value =
                              AvailableLanguage.values[index];
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
                            AvailableLanguage.values[index].title,
                            style: TextStyle(
                                color: controller.selectedLanguage.value ==
                                        AvailableLanguage.values[index]
                                    ? const Color(0xFF8F01DF)
                                    : const Color(0xFF171433).withOpacity(0.7),
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w600),
                          );
                        })),
                  );
          });
        },
        itemCount: AvailableLanguage.values.length,
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 20,
          );
        },
      ),
    );
  }
}
