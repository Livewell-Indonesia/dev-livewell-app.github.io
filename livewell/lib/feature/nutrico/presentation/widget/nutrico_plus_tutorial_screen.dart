import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:livewell/feature/nutrico/data/model/nutrico_plus_tutorial_asset_model.dart';

class NutricoPlusTutorialScreen extends StatelessWidget {
  final NutricoPlusTutorialAssetModel model;
  const NutricoPlusTutorialScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      height: 0.9.sh,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    size: 24.h,
                  )),
            ],
          ),
          24.verticalSpace,
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                Text(
                  model.nutricoImage?.title ?? "",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp, fontWeight: FontWeight.w700),
                ),
                24.verticalSpace,
                Html(data: model.nutricoImage?.subTitle ?? ""),
                16.verticalSpace,
                CachedNetworkImage(imageUrl: model.nutricoImage?.image1 ?? ""),
                16.verticalSpace,
                Html(data: model.nutricoImage?.example1Text ?? ""),
                16.verticalSpace,
                CachedNetworkImage(imageUrl: model.nutricoImage?.image2 ?? ""),
                16.verticalSpace,
                Html(data: model.nutricoImage?.example2Text ?? ""),
                16.verticalSpace,
                CachedNetworkImage(imageUrl: model.nutricoImage?.image3 ?? ""),
                16.verticalSpace,
                Html(data: model.nutricoImage?.example3Text ?? ""),
                32.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
