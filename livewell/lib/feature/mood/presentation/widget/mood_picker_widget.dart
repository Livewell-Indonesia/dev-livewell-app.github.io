import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:livewell/core/constant/constant.dart';

class MoodPickerWidget extends StatelessWidget {
  final Function(MoodType) onTap;
  const MoodPickerWidget({super.key, required this.onTap});

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
            'How are you?',
            style: TextStyle(
                color: const Color(0xFF171433).withOpacity(0.8),
                fontWeight: FontWeight.w600,
                fontSize: 16.sp),
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
  const MoodPickerItem({super.key, required this.moodType});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            moodType.assets(),
            width: 48,
            height: 48,
          ),
          4.verticalSpace,
          Text(
            moodType.title(),
            style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFF171433)),
          ),
        ],
      ),
    );
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

  String title() {
    switch (this) {
      case MoodType.great:
        return 'Great';
      case MoodType.good:
        return 'Good';
      case MoodType.meh:
        return 'Meh';
      case MoodType.bad:
        return 'Bad';
      case MoodType.awful:
        return 'Awful';
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
