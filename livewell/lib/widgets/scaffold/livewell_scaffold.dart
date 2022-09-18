import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LiveWellScaffold extends StatelessWidget {
  final String title;
  final Color? backgroundColor;
  final Widget body;
  const LiveWellScaffold(
      {Key? key,
      required this.title,
      this.backgroundColor = const Color(0xFFF1F1F1),
      required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          53.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16).r,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.centerLeft,
              children: [
                SizedBox(
                  width: double.infinity,
                  //color: Colors.red,
                  child: Center(
                    child: Text(
                      title,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child:
                        Navigator.canPop(context) ? backButton() : Container(),
                  ),
                ),
              ],
            ),
          ),
          body
        ],
      ),
    );
  }

  Widget backButton() {
    return GestureDetector(
      //behavior: HitTestBehavior.translucent,
      onTap: () {
        Get.back();
      },
      child: Container(
        width: 31.w,
        height: 31.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
          ),
        ),
      ),
    );
  }
}
