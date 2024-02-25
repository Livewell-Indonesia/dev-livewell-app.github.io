import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:livewell/core/constant/constant.dart';

enum SelectedNutriscorePlusMethod { camera, gallery, desc }

class NutriScorePlusBottomSheet extends StatelessWidget {
  final Function(SelectedNutriscorePlusMethod) onSelected;
  final Function(File) onImageSelected;
  const NutriScorePlusBottomSheet(
      {super.key, required this.onSelected, required this.onImageSelected});

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
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              onTap: () {
                onSelected(SelectedNutriscorePlusMethod.desc);
              },
              title: Text(
                'Describe Food',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF505050)),
              ),
              leading: SvgPicture.asset(
                Constant.icScanMeal,
                width: 24.w,
                height: 24.h,
                fit: BoxFit.scaleDown,
              ),
            ),
            ListTile(
              onTap: () {
                _pickImage(ImageSource.gallery, context);
              },
              title: Text(
                'Pick From Gallery',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF505050)),
              ),
              leading: const Icon(Icons.photo_library_outlined),
            ),
            ListTile(
              onTap: () {
                _pickImage(ImageSource.camera, context);
              },
              title: Text(
                'Take a Photo',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF505050)),
              ),
              leading: const Icon(Icons.add_a_photo_outlined),
            ),
          ],
        ),
      ),
    );
  }

  void _pickImage(ImageSource source, BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 75);
    // FilePickerResult? file =
    //     await FilePicker.platform.pickFiles(type: FileType.image);
    if (pickedFile != null) {
      onImageSelected(File(pickedFile.path));
      // final selectedImage = file.paths.map(
      //   (e) => File(e!),
      // );
      // onImageSelected(selectedImage.first);
    }
    //Navigator.of(context).pop();
  }
}
