import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/design_system.dart';

class LiveWellButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback? onPressed;
  final Color? textColor;
  const LiveWellButton(
      {required this.label,
      required this.color,
      this.onPressed,
      this.textColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Insets.paddingMedium),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shadowColor: Colors.transparent,
            fixedSize: Size(1.sw, 48.w),
            backgroundColor: color,
            disabledBackgroundColor: const Color(0xFFEBEBEB),
            padding: EdgeInsets.symmetric(
                horizontal: Insets.paddingMedium,
                vertical: Insets.paddingMedium.h),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36.0).r)),
        child: Text(
          label,
          style: TextStyle(
              color: onPressed == null
                  ? const Color(0xFF808080)
                  : textColor ?? Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
