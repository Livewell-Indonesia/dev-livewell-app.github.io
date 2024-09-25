import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/design_system.dart';

class LiveWellButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback? onPressed;
  final Color? textColor;
  final double? elevation;
  final bool wrapSize;
  final EdgeInsets? padding;
  const LiveWellButton({required this.label, required this.color, this.onPressed, this.textColor, this.elevation, this.wrapSize = false, this.padding, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Insets.paddingMedium),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            elevation: elevation,
            shadowColor: Colors.transparent,
            fixedSize: wrapSize ? null : Size(1.sw, 48.h),
            backgroundColor: color,
            disabledBackgroundColor: const Color(0xFFEBEBEB),
            padding: padding ?? const EdgeInsets.symmetric(horizontal: Insets.paddingMedium, vertical: Insets.paddingSmall),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36.0).r)),
        child: Text(
          label,
          style: TextStyle(color: onPressed == null ? const Color(0xFF808080) : textColor ?? Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
