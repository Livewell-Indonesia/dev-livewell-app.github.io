import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:io' show Platform;

class LiveWellScaffold extends StatelessWidget {
  final String title;
  final Color? backgroundColor;
  final Widget body;
  final bool allowBack;
  final Widget? trailing;
  const LiveWellScaffold(
      {Key? key,
      required this.title,
      this.backgroundColor = const Color(0xFFF1F1F1),
      required this.body,
      this.trailing,
      this.allowBack = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomWillPopScope(
      allowBack: allowBack,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              60.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Navigator.canPop(context) && allowBack
                            ? backButton()
                            : Container(),
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: trailing ?? Container())
                  ],
                ),
              ),
              body
            ],
          ),
        ),
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
        height: 31.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18.h,
          ),
        ),
      ),
    );
  }
}

class CustomWillPopScope extends StatelessWidget {
  // create constructor with widget as parameter
  final Widget child;
  final bool allowBack;
  const CustomWillPopScope(
      {Key? key, required this.child, this.allowBack = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!Platform.isIOS) {
      return WillPopScope(
        onWillPop: () {
          return Future.value(allowBack);
        },
        child: child,
      );
    } else {
      return GestureDetector(
          onHorizontalDragUpdate: (details) {
            int sensitivity = 40;
            if (details.delta.dx > sensitivity && allowBack) {
              Get.back();
            }
          },
          child: child);
    }
  }
}
