import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:livewell/theme/design_system.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';

class MinorUpdateBottomSheet extends StatelessWidget {
  const MinorUpdateBottomSheet({super.key, this.onUpdateTapped, this.onLaterTapped});
  final VoidCallback? onUpdateTapped;
  final VoidCallback? onLaterTapped;

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
                'Update Available',
                style: TextStyle(color: Theme.of(context).colorScheme.secondaryDarkBlue, fontSize: 24.sp, fontWeight: FontWeight.w600),
              ),
              8.verticalSpace,
              Text(
                'A new version of the app is available.\nPlease update to continue using the app.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).colorScheme.disabled, fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              32.verticalSpace,
              LiveWellButton(
                label: 'Update Now',
                onPressed: () {
                  onUpdateTapped!();
                },
                color: Theme.of(context).colorScheme.primaryGreen,
                textColor: Theme.of(context).colorScheme.secondaryDarkBlue,
              ),
              16.verticalSpace,
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      fixedSize: Size(1.sw, 52.w),
                      side: const BorderSide(width: 2, color: Color(0xFFDDF235)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(36.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16.h)),
                  onPressed: () {
                    onLaterTapped!();
                  },
                  child: Text(
                    "Update Later",
                    style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w500),
                  )),
              32.verticalSpace,
            ],
          ),
        ),
      ],
    );
  }
}
