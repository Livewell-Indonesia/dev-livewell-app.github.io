import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class AuthTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final bool obscureText;
  final bool? isEmail;
  final bool? enabled;
  final VoidCallback? onTap;
  final TextInputType keyboardType;
  final Color borderColor;
  final int minLines;
  final int maxLines;
  final double borderRadius;

  const AuthTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.errorText,
    required this.obscureText,
    this.enabled = true,
    this.onTap,
    this.isEmail = false,
    this.keyboardType = TextInputType.text,
    this.borderColor = const Color(0xFFDDF235),
    this.minLines = 1,
    this.maxLines = 1,
    this.borderRadius = 36.0,
  }) : super(key: key);
  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  final FocusNode _focusNode = FocusNode();
  bool isFocused = false;
  bool showPassword = false;

  @override
  void initState() {
    _focusNode.addListener(() {
      setState(() {
        isFocused = _focusNode.hasFocus;
      });
    });
    super.initState();
  }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: false,
      actions: widget.keyboardType == TextInputType.number || widget.keyboardType == const TextInputType.numberWithOptions(decimal: true)
          ? [
              KeyboardActionsItem(
                focusNode: _focusNode,
                toolbarButtons: [
                  (node) {
                    return GestureDetector(
                      onTap: () {
                        node.unfocus();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          'Done',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    );
                  }
                ],
              ),
            ]
          : [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      disableScroll: true,
      config: _buildConfig(context),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0).r,
        child: //create textformfield with green border
            Column(
          children: [
            TextFormField(
              minLines: widget.minLines,
              maxLines: widget.maxLines,
              keyboardType: widget.keyboardType,
              focusNode: _focusNode,
              style: TextStyle(color: const Color(0xFF000000), fontSize: 16.sp, fontWeight: FontWeight.w500),
              cursorColor: const Color(0xFF171433),
              controller: widget.controller,
              textInputAction: TextInputAction.done,
              obscureText: !showPassword && widget.obscureText,
              inputFormatters: widget.keyboardType == TextInputType.number || widget.keyboardType == const TextInputType.numberWithOptions(decimal: true)
                  ? Platform.isIOS
                      ? [
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            return newValue.copyWith(
                              text: newValue.text.replaceAll(RegExp(r"\,"), "."),
                            );
                          }),
                        ]
                      : [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                        ]
                  : [],
              enabled: widget.enabled,
              onTap: widget.onTap,
              decoration: InputDecoration(
                  //hintText: widget.hintText,
                  contentPadding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
                  labelText: widget.labelText,
                  isDense: true,
                  alignLabelWithHint: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelStyle: TextStyle(color: widget.errorText != null ? const Color(0xFFFA6F6F) : const Color(0xFF171433).withOpacity(0.5), fontSize: isFocused ? 13.sp : 16.sp),
                  hintStyle: TextStyle(color: const Color(0xFF171433).withOpacity(0.5), fontSize: 16.sp),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.errorText != null ? const Color(0xFFFA6F6F) : widget.borderColor,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(widget.borderRadius).r,
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.errorText != null ? const Color(0xFFFA6F6F) : widget.borderColor,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(widget.borderRadius).r,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.errorText != null ? const Color(0xFFFA6F6F) : widget.borderColor,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(widget.borderRadius).r,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.errorText != null ? const Color(0xFFFA6F6F) : widget.borderColor,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(widget.borderRadius).r,
                  ),
                  suffixIcon: suffixIcon()),
            ),
            if (widget.errorText != null) ...[
              8.verticalSpace,
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.errorText!,
                  style: const TextStyle(color: Color(0xFFFA6F6F), fontSize: 12, fontWeight: FontWeight.w400),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }

  Widget? suffixIcon() {
    if (widget.isEmail == true) {
      return Padding(
        padding: EdgeInsets.only(right: 32.0.w),
        child: Icon(
          Icons.done,
          color: widget.controller.text.isNotEmpty && widget.controller.text.isEmail ? const Color(0xFF505050) : Colors.transparent,
        ),
      );
    } else if (widget.obscureText == true) {
      return IconButton(
        padding: EdgeInsets.only(right: 32.0.w),
        onPressed: () {
          setState(() {
            showPassword = !showPassword;
          });
        },
        icon: Icon(
          showPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        ),
        color: showPassword ? const Color(0xFF505050) : const Color(0xFF505050),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(right: 32.0.w),
        child: const Icon(Icons.done, color: Colors.transparent),
      );
    }
  }
}
