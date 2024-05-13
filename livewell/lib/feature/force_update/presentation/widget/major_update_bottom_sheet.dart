import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:livewell/theme/design_system.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';

class MajorUpdateBottomSheet extends StatelessWidget {
  const MajorUpdateBottomSheet({super.key, this.onUpdateTapped});
  final VoidCallback? onUpdateTapped;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              24.verticalSpace,
              SvgPicture.asset('assets/icons/ic_force_update.svg'),
              32.verticalSpace,
              Text(
                'Update Required',
                style: TextStyle(color: Theme.of(context).colorScheme.secondaryDarkBlue, fontSize: 24.sp, fontWeight: FontWeight.w600),
              ),
              8.verticalSpace,
              Text(
                'A new version of the app is available.\nPlease update to continue using the app.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).colorScheme.disabled, fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
              32.verticalSpace,
              LiveWellButton(
                onPressed: () {
                  onUpdateTapped!();
                },
                label: 'Update Now',
                color: Theme.of(context).colorScheme.primaryGreen,
                textColor: Theme.of(context).colorScheme.secondaryDarkBlue,
              ),
              32.verticalSpace,
            ],
          ),
        ),
      ],
    );
  }
}
