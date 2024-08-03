import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';

class MoodPickerWidget extends StatelessWidget {
  final MoodType? selectedMoodType;
  final Function(MoodType) onTap;
  const MoodPickerWidget({super.key, required this.onTap, this.selectedMoodType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Get.find<HomeController>().localization.moodPage?.howAreYou ?? 'How are you?',
            style: TextStyle(color: const Color(0xFF171433).withOpacity(0.8), fontWeight: FontWeight.w600, fontSize: 16.sp),
          ),
          14.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: MoodType.values.map((e) {
              return InkWell(
                  onTap: () {
                    onTap(e);
                  },
                  child: MoodPickerItem(
                    selectedMoodType: selectedMoodType,
                    moodType: e,
                  ));
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class MoodPickerItem extends StatelessWidget {
  final MoodType moodType;
  final MoodType? selectedMoodType;
  const MoodPickerItem({super.key, required this.moodType, this.selectedMoodType});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          moodType.assets(),
          width: 48,
          height: 48,
          color: getColor(),
        ),
        4.verticalSpace,
        Text(
          moodType.title(),
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: const Color(0xFF171433)),
        ),
      ],
    );
  }

  Color? getColor() {
    if (selectedMoodType != null) {
      if (selectedMoodType == moodType) {
        return null;
      } else {
        return const Color(0xFF171433).withOpacity(0.3);
      }
    } else {
      return null;
    }
  }
}

enum MoodType { great, good, meh, bad, awful }

extension MoodTypeExt on MoodType {
  String assets() {
    switch (this) {
      case MoodType.great:
        return Constant.moodGreat;
      case MoodType.good:
        return Constant.moodGood;
      case MoodType.meh:
        return Constant.moodMeh;
      case MoodType.bad:
        return Constant.moodBad;
      case MoodType.awful:
        return Constant.moodAwful;
    }
  }

  Color mainColor() {
    switch (this) {
      case MoodType.great:
        return const Color(0xFFDDF235);
      case MoodType.good:
        return const Color(0xFF34EAB2);
      case MoodType.meh:
        return const Color(0xFF34A8EA);
      case MoodType.bad:
        return const Color(0xFF8F01DF);
      case MoodType.awful:
        return const Color(0xFFDF0101);
    }
  }

  static MoodType? getMoodTypeByValue(int value) {
    switch (value) {
      case 1:
        return MoodType.awful;
      case 2:
        return MoodType.bad;
      case 3:
        return MoodType.meh;
      case 4:
        return MoodType.good;
      case 5:
        return MoodType.great;
      default:
        return null;
    }
  }

  String title() {
    switch (this) {
      case MoodType.great:
        return Get.find<HomeController>().localization.moodPage?.great ?? 'Great';
      case MoodType.good:
        return Get.find<HomeController>().localization.moodPage?.good ?? 'Good';
      case MoodType.meh:
        return Get.find<HomeController>().localization.moodPage?.meh ?? 'Meh';
      case MoodType.bad:
        return Get.find<HomeController>().localization.moodPage?.bad ?? 'Bad';
      case MoodType.awful:
        return Get.find<HomeController>().localization.moodPage?.awful ?? 'Awful';
    }
  }

  int value() {
    switch (this) {
      case MoodType.great:
        return 5;
      case MoodType.good:
        return 4;
      case MoodType.meh:
        return 3;
      case MoodType.bad:
        return 2;
      case MoodType.awful:
        return 1;
    }
  }
}
