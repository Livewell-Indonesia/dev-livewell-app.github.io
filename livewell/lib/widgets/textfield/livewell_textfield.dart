import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LiveWellTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final bool obscureText;
  final bool? isEmail;

  const LiveWellTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.errorText,
    required this.obscureText,
    this.isEmail = false,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0).r,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(36.0).r,
        border: const Border(
          top: BorderSide(
            color: Color(0xFFDDF235),
            width: 3.0,
          ),
          bottom: BorderSide(
            color: Color(0xFFDDF235),
            width: 3.0,
          ),
          left: BorderSide(
            color: Color(0xFFDDF235),
            width: 3.0,
          ),
          right: BorderSide(
            color: Color(0xFFDDF235),
            width: 3.0,
          ),
        ),
      ),
      child: //create textformfield with green border
          TextFormField(
        focusNode: _focusNode,
        style: TextStyle(color: Color(0xFF171433), fontSize: 17.sp),
        cursorColor: const Color(0xFF171433),
        controller: widget.controller,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0).r,
            //hintText: widget.hintText,
            labelText: widget.labelText,
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
    );
  }

  Widget? suffixIcon() {
    if (widget.isEmail == true) {
      return Icon(getIcon(), color: Color(0xFF8F01DF));
    } else if (widget.obscureText == true) {
      return IconButton(
        onPressed: () {
          setState(() {
            showPassword = !showPassword;
          });
        },
        icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
        color: showPassword ? Color(0xFF8F01DF) : Color(0xFF8F01DF),
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
