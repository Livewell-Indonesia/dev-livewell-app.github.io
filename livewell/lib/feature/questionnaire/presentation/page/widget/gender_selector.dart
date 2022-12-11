import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/feature/questionnaire/presentation/controller/questionnaire_controller.dart';

class GenderSelector extends StatelessWidget {
  final QuestionnaireController controller = Get.find();
  GenderSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(child: genderButton(Gender.male, () {})),
        Flexible(child: genderButton(Gender.female, () {})),
      ],
    );
  }

  Column genderButton(Gender gender, VoidCallback onTap) {
    return Column(
      children: [
        SizedBox(
            height: 0.19.sh,
            width: 0.346.sw,
            child: Obx(() {
              return InkWell(
                onTap: () {
                  controller.selectedGender.value = gender;
                },
                child: Opacity(
                  opacity:
                      gender == controller.selectedGender.value ? 1.0 : 0.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0).r,
                    child: Container(
                      decoration: BoxDecoration(
                        color: gender == Gender.male
                            ? const Color(0xFFDDF235)
                            : const Color(0xFF7FE4F0),
                      ),
                      padding:
                          const EdgeInsets.only(left: 12, right: 12, top: 20).r,
                      child: SvgPicture.asset(
                        gender == Gender.male
                            ? Constant.imgMaleSVG
                            : Constant.imgFemaleSVG,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
              );
            })),
        19.verticalSpace,
        Obx(() {
          return Text(
            gender.label(),
            style: TextStyle(
                color: gender == controller.selectedGender.value
                    ? const Color(0xFFDDF235)
                    : const Color(0xFF171433).withOpacity(0.8),
                fontSize: 18.sp),
          );
        })
      ],
    );
  }
}
