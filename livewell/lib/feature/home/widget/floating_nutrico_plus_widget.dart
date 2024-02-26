import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:livewell/core/constant/constant.dart';

class FloatingNutricoPlusWidget extends StatelessWidget {
  final VoidCallback? onTap;
  const FloatingNutricoPlusWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: 64.w,
            height: 64.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFDDF235),
            ),
          ),
          Positioned(
            left: 16.w,
            top: 12.h,
            child: SvgPicture.asset(
              Constant.icBarcode,
              width: 30,
              height: 30,
              fit: BoxFit.scaleDown,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: const Color(0xFF8F01DF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Nutrico+',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 10.sp),
            ),
          ),
        ],
      ),
    );
  }
}
