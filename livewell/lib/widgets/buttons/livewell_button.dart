import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/design_system.dart';

class LiveWellButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;
  final Color? textColor;
  const LiveWellButton(
      {required this.label,
      required this.color,
      required this.onPressed,
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
            minimumSize: Size(double.infinity, 44.w),
            primary: color,
            padding: const EdgeInsets.symmetric(
                    horizontal: Insets.paddingMedium, vertical: 21.0)
                .r,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36.0).r)),
        child: Text(
          label,
          style: TextStyle(
              color: textColor ?? Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
