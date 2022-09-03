import 'package:flutter/material.dart';
import '../../theme/design_system.dart';

class PrimaryTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final bool obscureText;
  final TextEditingController controller;
  const PrimaryTextField(
      {required this.controller,
      required this.hintText,
      required this.errorText,
      required this.obscureText,
      required this.labelText,
      Key? key})
      : super(key: key);

  @override
  State<PrimaryTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  bool showPassword = false;
  FocusNode _focusNode = FocusNode();
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Insets.paddingMedium),
      decoration: BoxDecoration(
        color: isFocused ? Colors.white : AppColors.primary5,
        borderRadius: BorderRadius.circular(36.0),
        border: Border(
          top: BorderSide(
            color: isFocused ? AppColors.primary100 : AppColors.primary5,
            width: 1.0,
          ),
          bottom: BorderSide(
            color: isFocused ? AppColors.primary100 : AppColors.primary5,
            width: 1.0,
          ),
          left: BorderSide(
            color: isFocused ? AppColors.primary100 : AppColors.primary5,
            width: 1.0,
          ),
          right: BorderSide(
            color: isFocused ? AppColors.primary100 : AppColors.primary5,
            width: 1.0,
          ),
        ),
      ),
      child: TextFormField(
        focusNode: _focusNode,
        controller: widget.controller,
        cursorColor: AppColors.primary75,
        obscureText: widget.obscureText ? !showPassword : false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
                horizontal: Insets.spacingLarge,
                vertical: Insets.paddingMedium),
            labelText: widget.labelText,
            hintText: widget.hintText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: TextStyles.bodySmallStrong(color: AppColors.textHiEm),
            hintStyle: TextStyles.body(color: AppColors.textLoEm),
            suffixIcon: widget.obscureText
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off),
                    color:
                        showPassword ? AppColors.primary75 : AppColors.textLoEm,
                  )
                : null,
            border: InputBorder.none),
      ),
    );
  }
}
