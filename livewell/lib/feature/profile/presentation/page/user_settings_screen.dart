import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:livewell/core/base/base_controller.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/feature/profile/presentation/controller/physical_information_controller.dart';
import 'package:livewell/feature/profile/presentation/controller/user_settings_controller.dart';
import 'package:livewell/feature/profile/presentation/page/my_goals_screen.dart';
import 'package:livewell/feature/questionnaire/presentation/controller/questionnaire_controller.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';

class UserSettingsScreen extends StatelessWidget {
  final UserSettingsController controller = Get.put(UserSettingsController());
  final PhysicalInformationController physicalController =
      Get.put(PhysicalInformationController());
  UserSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh,
      color: const Color(0xFFF1F1F1),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                const ProfileBackground(),
                Column(
                  children: [
                    Navigator.of(context).canPop()
                        ? Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              //behavior: HitTestBehavior.translucent,
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                margin: const EdgeInsets.only(left: 16).r,
                                width: 31.w,
                                height: 31.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const SizedBox(
                                  child: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    Container(
                      width: 210.w,
                      height: 210.h,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          shape: BoxShape.circle),
                      alignment: Alignment.center,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          ClipOval(
                              child: InkWell(
                            onTap: () async {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return ImagePickerBottomSheet(
                                        onImageSelected: (img) {
                                      physicalController.pickImages(img);
                                    });
                                  });
                            },
                            child: Container(
                              width: 180.w,
                              height: 180.h,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Obx(() {
                                if (controller.user.value.avatarUrl != null &&
                                    controller
                                        .user.value.avatarUrl!.isNotEmpty) {
                                  return Image.network(
                                    controller.user.value.avatarUrl!,
                                    fit: BoxFit.cover,
                                  );
                                } else {
                                  return SvgPicture.asset(
                                    (controller.user.value.gender ??
                                                    Gender.male.name)
                                                .toLowerCase() ==
                                            "male"
                                        ? Constant.imgMaleSVG
                                        : Constant.imgFemaleSVG,
                                  );
                                }
                              }),
                            ),
                          )),
                          // create plus button
                          Container(
                            width: 40.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    13.verticalSpace,
                    Obx(() {
                      return Text(
                        "${controller.user.value.firstName ?? ""} ${controller.user.value.lastName ?? ""}",
                        style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF171433)),
                      );
                    })
                    // Text(
                    //   'Indonesia ${flagEmoji('ID')}',
                    //   style: TextStyle(fontSize: 18.sp),
                    // ),
                  ],
                ),
              ],
            ),
            //32.verticalSpace,
            ProfileSettingsItem(
                title: controller.localization.accountSettings!,
                icon: Image.asset(Constant.icAccountSetting),
                onPressed: () {
                  controller.accountSettingsTap();
                }),
            8.verticalSpace,
            ProfileSettingsItem(
                title: controller.localization.dailyJournal!,
                icon: Icon(
                  Icons.class_outlined,
                  size: 20.w,
                ),
                onPressed: () {
                  controller.dailyJournalTapped();
                }),
            8.verticalSpace,
            ProfileSettingsItem(
                title: controller.localization.physicalInformation!,
                icon: Icon(
                  Icons.accessibility_new,
                  size: 20.w,
                ),
                onPressed: () {
                  controller.physicalInformationTapped();
                }),
            8.verticalSpace,
            ProfileSettingsItem(
                title: controller.localization.exercise!,
                icon: Image.asset(Constant.icExerciseBlack3),
                onPressed: () {
                  controller.exerciseInformationTapped();
                }),
            8.verticalSpace,
            ProfileSettingsItem(
                title: controller.localization.myGoals!,
                icon: const Icon(Icons.ballot_outlined, size: 20),
                onPressed: () {
                  Get.to(() => MyGoalsScreen());
                }),

            8.verticalSpace,
            ProfileSettingsItem(
                title: controller.localization.languages ?? "",
                icon: const Icon(Icons.language, size: 20),
                onPressed: () {
                  Get.dialog(
                      Dialog(
                          child: SizedBox(
                              height: 200.h,
                              child: Obx(() {
                                return Column(
                                  children: [
                                    ListTile(
                                      leading: Text(AvailableLanguage.en.title),
                                      trailing: Radio(
                                          value: AvailableLanguage.en.locale,
                                          groupValue:
                                              controller.language.value.locale,
                                          onChanged: (val) {
                                            controller.setValue(val as String);
                                          }),
                                    ),
                                    ListTile(
                                      leading: Text(AvailableLanguage.id.title),
                                      trailing: Radio(
                                          value: AvailableLanguage.id.locale,
                                          groupValue:
                                              controller.language.value.locale,
                                          onChanged: (val) {
                                            controller.setValue(val as String);
                                          }),
                                    ),
                                    LiveWellButton(
                                        label: controller
                                            .localization.saveChanges!,
                                        color: const Color(0xFF8F01DF),
                                        textColor: Colors.white,
                                        onPressed: () {
                                          Get.back();
                                          controller.updateData();
                                        })
                                  ],
                                );
                              }))),
                      barrierDismissible: false);
                }),
            8.verticalSpace,
            ProfileSettingsItem(
              title: controller.localization.logout!,
              icon: Image.asset(Constant.icLogout),
              onPressed: () {
                controller.logoutTapped();
              },
            ),
            100.verticalSpace,
          ],
        ),
      ),
    );
  }
}

class ProfileSettingsItem extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback onPressed;

  const ProfileSettingsItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        width: 335.w,
        height: 72.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30).r,
        ),
        child: Row(
          children: [
            Container(
              width: 43.h,
              height: 43.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: const Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(15).r),
              child: SizedBox(
                width: 20.w,
                height: 20.h,
                child: icon,
              ),
            ),
            18.horizontalSpace,
            Text(
              title,
              style: TextStyle(
                  color: const Color(0xFF171433).withOpacity(0.8),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios_rounded)
          ],
        ),
      ),
    );
  }
}

class ProfileBackground extends StatelessWidget {
  const ProfileBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SizedBox(
          height: 380.h,
          width: 1.sw,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 176.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDDF235),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

String flagEmoji(String country) {
  int base = 0x1F1E6;
  int a = 'A'.codeUnitAt(0);
  int offset = country.codeUnitAt(0) - a;
  int first = base + offset;
  offset = country.codeUnitAt(1) - a;
  int second = base + offset;
  return String.fromCharCode(first) + String.fromCharCode(second);
}

class ImagePickerBottomSheet extends StatelessWidget {
  final Function(File) onImageSelected;

  ImagePickerBottomSheet({required this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 40),
      child: Wrap(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text(
              'Pick from Gallery',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              _pickImage(ImageSource.gallery, context);
            },
          ),
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text(
              'Take a Photo',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              _pickImage(ImageSource.camera, context);
            },
          ),
          40.verticalSpace,
        ],
      ),
    );
  }

  void _pickImage(ImageSource source, BuildContext context) async {
    final picker = ImagePicker();
    //final pickedFile = await picker.pickImage(source: source);
    FilePickerResult? file =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (file != null) {
      final selectedImage = file.paths.map(
        (e) => File(e!),
      );
      onImageSelected(selectedImage.first);
    }
    //Navigator.of(context).pop();
  }
}
