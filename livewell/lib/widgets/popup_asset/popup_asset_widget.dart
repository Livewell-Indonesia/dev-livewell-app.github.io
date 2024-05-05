import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:livewell/feature/dashboard/data/model/popup_assets_model.dart';

class PopupAssetWidget extends StatelessWidget {
  final Exercise exercise;
  const PopupAssetWidget({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  children: [
                    Text('Info', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: const Color(0xFF171433))),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              Html(
                data: exercise.abovePicture,
                style: {
                  "body": Style(
                    fontSize: FontSize(14.sp),
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF171433),
                  )
                },
              ),
              8.verticalSpace,
              CachedNetworkImage(imageUrl: exercise.picture!),
              8.verticalSpace,
              Html(
                data: exercise.belowPicture,
                style: {
                  "body": Style(
                    fontSize: FontSize(14.sp),
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF171433),
                  )
                },
              ),
              8.verticalSpace,
              Html(
                data: exercise.extrasBelow,
                style: {
                  "body": Style(
                    fontSize: FontSize(14.sp),
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF171433),
                  )
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
