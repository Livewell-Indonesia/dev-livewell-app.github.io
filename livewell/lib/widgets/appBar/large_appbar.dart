import 'package:flutter/material.dart';

import '../../theme/design_system.dart';

class LargeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? backgroundColor;
  const LargeAppBar({required this.title, this.backgroundColor, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      width: preferredSize.width,
      color: backgroundColor ?? AppColors.primary5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Insets.spacingLarge, vertical: Insets.spacingLarge),
            child: Text(title,
                style: TextStyles.subTitleHiEm(color: AppColors.primary100)),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
