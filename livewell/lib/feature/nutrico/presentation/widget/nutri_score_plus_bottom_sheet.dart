import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:livewell/core/base/usecase.dart';
import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:livewell/core/helper/tracker/livewell_tracker.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/nutrico/domain/usecase/get_nutrico_plus_tutorial_asset.dart';
import 'package:livewell/feature/nutrico/presentation/widget/nutrico_plus_tutorial_screen.dart';

enum SelectedNutriscorePlusMethod { camera, gallery, desc }

class NutriScorePlusBottomSheet extends StatefulWidget {
  final bool isAlreadyLimit;
  final bool isFromDashboard;
  final int maxRequest;
  final Function(SelectedNutriscorePlusMethod) onSelected;
  final Function(File) onImageSelected;
  const NutriScorePlusBottomSheet({super.key, required this.onSelected, required this.onImageSelected, required this.isAlreadyLimit, required this.maxRequest, this.isFromDashboard = true});

  @override
  State<NutriScorePlusBottomSheet> createState() => _NutriScorePlusBottomSheetState();
}

class _NutriScorePlusBottomSheetState extends State<NutriScorePlusBottomSheet> {
  @override
  void initState() {
    determineShowTutorialFirstTime();
    super.initState();
  }

  void determineShowTutorialFirstTime() async {
    final bool showTutorial = await SharedPref.isFirstTimeOpenNutrico();
    if (showTutorial) {
      await SharedPref.saveFirstTimeOpenNutrico(false);
      loadTutorial();
    }
  }

  void loadTutorial() async {
    EasyLoading.show();
    final response = await GetNutricoPlusTutorialAsset.instance().call(NoParams());
    EasyLoading.dismiss();
    response.fold((l) {}, (r) {
      showModalBottomSheet(
        //showDragHandle: true,
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (context) {
          return NutricoPlusTutorialScreen(model: r);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 32.h),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            24.verticalSpace,
            Text(Get.find<DashboardController>().localization.nutricoPlusBottomSheet?.manualDescribeYourFood ?? "Manual Describe Your Food",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: const Color(0xFF171433))),
            ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: () {
                widget.onSelected(SelectedNutriscorePlusMethod.desc);
              },
              title: Text(
                Get.find<DashboardController>().localization.nutricoPlusBottomSheet?.describeFood ?? "Describe Food",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: const Color(0xFF505050)),
              ),
              leading: const Icon(
                Icons.edit_outlined,
                color: Color(0xFF505050),
              ),
            ),
            16.verticalSpace,
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(Get.find<DashboardController>().localization.nutricoPlusBottomSheet?.generateFromImage ?? "Generate From Image",
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: const Color(0xFF171433))),
                    8.verticalSpace,
                    Text(
                        '${Get.find<DashboardController>().localization.nutricoPlusBottomSheet?.maximumGenerateOf ?? "Maximum generate of"} ${widget.maxRequest} ${Get.find<DashboardController>().localization.nutricoPlusBottomSheet?.imagesPerMonth ?? "images per month"}',
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xFF808080))),
                  ],
                ),
                const Spacer(),
                InkWell(
                    onTap: () {
                      Get.find<DashboardController>()
                          .trackEvent(widget.isFromDashboard ? LivewellHomepageEvent.navbarNutricoInformationButton : LivewellMealLogEvent.mealLogPageNutricoInformationButton);
                      loadTutorial();
                    },
                    child: Icon(Icons.info_outline, color: const Color(0xFF171433), size: 24.sp)),
              ],
            ),
            16.verticalSpace,
            ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: widget.isAlreadyLimit
                  ? null
                  : () {
                      EasyLoading.show();
                      Get.find<DashboardController>()
                          .trackEvent(widget.isFromDashboard ? LivewellHomepageEvent.navbarNutricoPickFromGalleryButton : LivewellMealLogEvent.mealLogPageNutricoPickFromGalleryButton);
                      _pickImage(ImageSource.gallery, context);
                    },
              title: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Get.find<DashboardController>().localization.nutricoPlusBottomSheet?.pickFromGallery ?? "Pick From Gallery",
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: widget.isAlreadyLimit ? const Color(0xFF808080) : const Color(0xFF505050)),
                      ),
                      widget.isAlreadyLimit
                          ? Text(
                              Get.find<DashboardController>().localization.nutricoPlusBottomSheet?.maxRequestReached ?? "Max request reached",
                              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: const Color(0xFF808080)),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ],
              ),
              leading: Icon(
                Icons.photo_library_outlined,
                color: widget.isAlreadyLimit ? const Color(0xFF808080) : const Color(0xFF505050),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: widget.isAlreadyLimit
                  ? null
                  : () {
                      Get.find<DashboardController>()
                          .trackEvent(widget.isFromDashboard ? LivewellHomepageEvent.navbarNutricoTakeAPhotoButton : LivewellMealLogEvent.mealLogPageNutricoTakeAPhotoButton);
                      _pickImage(ImageSource.camera, context);
                    },
              title: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Get.find<DashboardController>().localization.nutricoPlusBottomSheet?.takeAPhoto ?? "Take a Photo",
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: widget.isAlreadyLimit ? const Color(0xFF808080) : const Color(0xFF505050)),
                      ),
                      widget.isAlreadyLimit
                          ? Text(
                              Get.find<DashboardController>().localization.nutricoPlusBottomSheet?.maxRequestReached ?? "Max request reached",
                              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: const Color(0xFF808080)),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ],
              ),
              leading: Icon(
                Icons.add_a_photo_outlined,
                color: widget.isAlreadyLimit ? const Color(0xFF808080) : const Color(0xFF505050),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _pickImage(ImageSource source, BuildContext context) async {
    final picker = ImagePicker();
    EasyLoading.show();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 65);
    // FilePickerResult? file =
    //     await FilePicker.platform.pickFiles(type: FileType.image);
    if (pickedFile != null) {
      final File file = File(pickedFile.path);
      final Uint8List imageBytes = await file.readAsBytes();
      final File resizedImage = await resizeImageToTargetSize(imageBytes, 250, pickedFile.path);
      widget.onImageSelected(resizedImage);
      // final selectedImage = file.paths.map(
      //   (e) => File(e!),
      // );
      // onImageSelected(selectedImage.first);
    }
    EasyLoading.dismiss();
    //Navigator.of(context).pop();
  }
}

Future<File> resizeImageToTargetSize(Uint8List imageBytes, int targetSizeKB, String filePath) async {
  int quality = 100; // Initial quality, can be adjusted
  int maxIterations = 10; // You can adjust this based on your needs
  Uint8List compressedImage = imageBytes;

  for (int i = 0; i < maxIterations; i++) {
    compressedImage = await FlutterImageCompress.compressWithList(
      imageBytes,
      quality: quality,
    );

    if (compressedImage.lengthInBytes <= targetSizeKB * 1024) {
      File file = File(filePath);
      return file.writeAsBytes(compressedImage);
    }

    // Adjust quality for next iteration
    quality -= 10;
    if (quality < 0) {
      quality = 0;
    }
  }

  // If the loop completes without reaching target size, return the last compressed image
  File file = File(filePath);
  return file.writeAsBytes(compressedImage);
}
