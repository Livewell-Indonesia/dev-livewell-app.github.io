import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubtitleQuestionnaire extends StatelessWidget {
  final String title;
  final Color color;
  final bool isBold;
  const SubtitleQuestionnaire({super.key, required this.title, this.color = const Color(0xFF171433), this.isBold = true});

  @override
  Widget build(BuildContext context) {
    return Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 16.sp, color: color, fontWeight: isBold ? FontWeight.w600 : FontWeight.w500));
  }
}
