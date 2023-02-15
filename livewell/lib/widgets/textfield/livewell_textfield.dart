import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class LiveWellTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final bool obscureText;
  final bool? isEmail;
  final bool? enabled;
  final VoidCallback? onTap;
  final TextInputType keyboardType;

  const LiveWellTextField({
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
  }) : super(key: key);
  @override
  State<LiveWellTextField> createState() => _LiveWellTextFieldState();
}

class _LiveWellTextFieldState extends State<LiveWellTextField> {
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
      actions: widget.keyboardType == TextInputType.number ||
              widget.keyboardType ==
                  const TextInputType.numberWithOptions(decimal: true)
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
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(36.0).r,
          border: Border.all(
            color: widget.errorText == null
                ? const Color(0xFFDDF235)
                : const Color(0xFFFA6F6F),
            width: 3.0,
          ),
        ),
        child: //create textformfield with green border
            TextFormField(
          keyboardType: widget.keyboardType,
          focusNode: _focusNode,
          style: TextStyle(color: const Color(0xFF171433), fontSize: 17.sp),
          cursorColor: const Color(0xFF171433),
          controller: widget.controller,
          textInputAction: TextInputAction.done,
          obscureText: !showPassword && widget.obscureText,
          inputFormatters: widget.keyboardType == TextInputType.number ||
                  widget.keyboardType ==
                      const TextInputType.numberWithOptions(decimal: true)
              ? Platform.isIOS
                  ? [
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        return newValue.copyWith(
                          text: newValue.text.replaceAll(RegExp(r"\,"), "."),
                        );
                      }),
                    ]
                  : [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}')),
                    ]
              : [],
          enabled: widget.enabled,
          onTap: widget.onTap,
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0).r,
              //hintText: widget.hintText,
              labelText: widget.errorText ?? widget.labelText,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              labelStyle: TextStyle(
                  color: const Color(0xFF171433).withOpacity(0.5),
                  fontSize: isFocused ? 13.sp : 17.sp),
              hintStyle: TextStyle(
                  color: const Color(0xFF171433).withOpacity(0.5),
                  fontSize: 18.sp),
              border: InputBorder.none,
              suffixIcon: suffixIcon()),
        ),
      ),
    );
  }

  Widget? suffixIcon() {
    if (widget.isEmail == true) {
      return Icon(getIcon(), color: const Color(0xFF8F01DF));
    } else if (widget.obscureText == true) {
      return IconButton(
        onPressed: () {
          setState(() {
            showPassword = !showPassword;
          });
        },
        icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
        color: showPassword ? const Color(0xFF8F01DF) : const Color(0xFF8F01DF),
      );
    } else {
      return null;
    }
  }

  IconData getIcon() {
    if (widget.controller.text.isEmpty) {
      return Icons.check_circle_outline_sharp;
    } else if (widget.controller.text.isEmail) {
      return Icons.check_circle_outline_sharp;
    } else {
      return Icons.close;
    }
  }
}
