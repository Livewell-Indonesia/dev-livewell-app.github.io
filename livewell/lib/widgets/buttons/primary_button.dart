import 'package:flutter/material.dart';

import '../../theme/design_system.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;
  const PrimaryButton(
      {required this.label,
      required this.color,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Insets.paddingMedium),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 44),
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(
                horizontal: Insets.paddingMedium,
                vertical: Insets.paddingMedium),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0))),
        child: Text(
          label,
          style: TextStyles.bodyStrong(color: Colors.white),
        ),
      ),
    );
  }
}
