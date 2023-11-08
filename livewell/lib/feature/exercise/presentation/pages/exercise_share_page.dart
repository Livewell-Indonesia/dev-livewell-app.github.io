import 'dart:io';

import 'package:appinio_social_share/appinio_social_share.dart';
import 'package:davinci/davinci.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/feature/exercise/presentation/pages/exercise_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:social_share/social_share.dart';

class ExerciseSharePage extends StatelessWidget {
  final File file;
  final num aspectRatio;
  final String title;
  final num steps;
  final num distance;
  final num calories;
  final String location;

  const ExerciseSharePage({super.key, required this.file, this.aspectRatio = 9 / 16, required this.title, required this.steps, required this.distance, required this.calories, required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh,
      width: 1.sw,
      color: Color(0xFF505050),
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 24.sp,
              ),
            ),
          )),
          Expanded(
            flex: 8,
            child: Column(
              children: [
                Text("Share Your goal's progress with friend", textAlign: TextAlign.center, style: TextStyle(fontSize: 24.sp, color: const Color(0xFFFFFFFF), fontWeight: FontWeight.w600)),
                42.verticalSpace,
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: ImageWithOverlay(
                      file: file,
                      overlayText: "",
                      aspectRatio: aspectRatio.toDouble(),
                      title: title,
                      steps: steps.toInt(),
                      distance: distance.toDouble(),
                      calories: calories.toInt(),
                      location: location),
                ),
                30.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: ShareButtonType.values.map((e) {
                    return InkWell(
                      onTap: () async {
                        EasyLoading.show();
                        final result = await DavinciCapture.offStage(
                            ImageWithOverlay(
                                file: file,
                                overlayText: "",
                                aspectRatio: aspectRatio.toDouble(),
                                title: title,
                                steps: steps.toInt(),
                                distance: distance.toDouble(),
                                calories: calories.toInt(),
                                location: location),
                            context: context,
                            pixelRatio: Get.pixelRatio * 4,
                            fileName: 'livewell',
                            wait: const Duration(seconds: 2),
                            returnImageUint8List: true);
                        final tempDir = await getTemporaryDirectory();
                        final files = File('${tempDir.path}/livewell.jpg');
                        EasyLoading.dismiss();
                        if (result != null) {
                          await files.writeAsBytes(result!);
                          switch (e) {
                            case ShareButtonType.instagram:
                              await AppinioSocialShare().shareToInstagramStory("108487895683370", backgroundImage: files.path);
                            // SocialShare.shareInstagramStory(
                            //     appId: "108487895683370",
                            //     imagePath: files.path);
                            case ShareButtonType.facebook:
                              await AppinioSocialShare().shareToFacebookStory("108487895683370", backgroundImage: files.path);
                            // SocialShare.shareFacebookStory(
                            //     appId: "108487895683370",
                            //     imagePath: files.path);
                            default:
                              await AppinioSocialShare().shareToSystem(title, "", filePath: files.path);
                            //Share.shareXFiles([XFile(files.path)]);
                          }
                        }
                      },
                      child: Container(
                        width: 40.h,
                        height: 40.h,
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            e.widget(),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.transparent,
              size: 24.sp,
            ),
          )),
        ],
      ),
    );
  }
}

enum ShareButtonType {
  instagram,
  facebook,
  // twitter,
  // whatsapp,
  // telegram,
  other,
}

extension ShareButtonTypeData on ShareButtonType {
  Widget widget() {
    switch (this) {
      case ShareButtonType.instagram:
        return SizedBox(width: 24.h, height: 24.h, child: Image.asset(Constant.icInstagramPng));
      case ShareButtonType.facebook:
        return SizedBox(width: 24.h, height: 24.h, child: Image.asset(Constant.icFacebookPng));
      // case ShareButtonType.whatsapp:
      //   return Container();
      // // return Image.asset(
      // //   Constant.icWhatsappPng,
      // //   width: 24.h,
      // //   height: 24.h,
      // //   fit: BoxFit.cover,
      // // );
      // case ShareButtonType.telegram:
      //   return Container();
      // // return Image.asset(
      // //   Constant.icWhatsappPng,
      // //   width: 24.h,
      // //   height: 24.h,
      // //   fit: BoxFit.cover,
      // // );
      // case ShareButtonType.twitter:
      //   return Container();
      // // return Image.asset(
      // //   Constant.icWhatsappPng,
      // //   width: 24.h,
      // //   height: 24.h,
      // //   fit: BoxFit.cover,
      // // );
      case ShareButtonType.other:
        return SizedBox(width: 24.h, height: 24.h, child: Icon(Icons.more_horiz, color: Colors.black, size: 24.sp));
    }
  }
}
