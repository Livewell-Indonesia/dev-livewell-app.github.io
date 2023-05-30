import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/feature/profile/presentation/controller/account_settings_controller.dart';
import 'package:livewell/feature/profile/presentation/controller/physical_information_controller.dart';
import 'package:livewell/feature/profile/presentation/controller/user_settings_controller.dart';
import 'package:livewell/feature/profile/presentation/page/user_settings_screen.dart';
import 'package:livewell/feature/questionnaire/presentation/controller/questionnaire_controller.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';

class AccountSettingsScreen extends StatelessWidget {
  final AccountSettingsController controller =
      Get.put(AccountSettingsController());
  final UserSettingsController userController = Get.find();
  final PhysicalInformationController physicalController = Get.find();
  AccountSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            color: const Color(0xFFF1F1F1),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    const ProfileBackground(),
                    Column(
                      children: [
                        Align(
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
                        ),
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
                                    if (userController.user.value.avatarUrl !=
                                            null &&
                                        userController
                                            .user.value.avatarUrl!.isNotEmpty) {
                                      return Image.network(
                                        userController.user.value.avatarUrl!,
                                        fit: BoxFit.cover,
                                      );
                                    } else {
                                      return SvgPicture.asset(
                                        (userController.user.value.gender ??
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
                      ],
                    ),
                  ],
                ),
                LiveWellButton(
                  label: 'Request To Delete Account'.tr,
                  color: Colors.red,
                  textColor: Colors.white,
                  onPressed: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: const Text('Delete Account Permanently'),
                            content: const Text(
                                'You account and content will be deleted permanently. You may cancel the deletion request by logging in your account within 30 days.'),
                            actions: [
                              CupertinoDialogAction(
                                child: Text('Cancel'.tr),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                              CupertinoDialogAction(
                                child: Text('Confirm'.tr),
                                onPressed: () {
                                  controller.requestAccountDeletion();
                                },
                              ),
                            ],
                          );
                        });
                  },
                ),
                30.verticalSpace,
                Container(
                  width: 1.sw,
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      // Top Section
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.w, vertical: 15.h),
                        height: 55.h,
                        width: 1.sw,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.r),
                                topRight: Radius.circular(30.r))),
                        child: Row(
                          children: [
                            Text(
                              'Personal Information'.tr,
                              style: TextStyle(
                                  color: const Color(0xFF171433),
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.edit_outlined,
                              size: 15.h,
                              color: const Color(0xFF8F01DF),
                            ),
                          ],
                        ),
                      ),
                      30.verticalSpace,
                      AccountSettingsTextField(
                        textEditingController: controller.firstName,
                        hintText: 'First Name'.tr,
                      ),
                      20.verticalSpace,
                      AccountSettingsTextField(
                        textEditingController: controller.lastName,
                        hintText: 'Last Name'.tr,
                      ),
                      20.verticalSpace,
                      AccountSettingsTextField(
                        textEditingController: controller.email,
                        hintText: 'Email'.tr,
                        enabled: false,
                      )
                    ],
                  ),
                ),
                20.verticalSpace,
                LiveWellButton(
                    label: 'Update'.tr,
                    color: const Color(0xFF8F01DF),
                    textColor: Colors.white,
                    onPressed: () {
                      controller.validate();
                    }),
                20.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AccountSettingsTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final bool enabled;
  final TextInputType inputType;
  final List<TextInputFormatter> inputFormatter;
  final Color textColor;
  final Color labelColor;
  const AccountSettingsTextField({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    this.enabled = true,
    this.inputType = TextInputType.text,
    this.textColor = const Color(0xFF8F01DF),
    this.labelColor = const Color(0xFF000000),
    this.inputFormatter = const [],
  }) : super(key: key);

  @override
  State<AccountSettingsTextField> createState() =>
      _AccountSettingsTextFieldState();
}

class _AccountSettingsTextFieldState extends State<AccountSettingsTextField> {
  final FocusNode _focusNode = FocusNode();

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: false,
      actions: widget.inputType == TextInputType.number ||
              widget.inputType ==
                  const TextInputType.numberWithOptions(decimal: true)
          ? [
              KeyboardActionsItem(
                focusNode: _focusNode,
                toolbarButtons: [
                  (node) {
                    return GestureDetector(
                      onTap: () {
                        node.unfocus();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          'Done',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    );
                  }
                ],
              ),
            ]
          : [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      config: _buildConfig(context),
      disableScroll: true,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0.w),
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(36.r),
          border: Border.all(
            color: const Color(0xFFDDF235),
            width: 3,
          ),
        ),
        alignment: Alignment.center,
        child: TextFormField(
          keyboardType: widget.inputType,
          enabled: widget.enabled,
          textAlign: TextAlign.end,
          focusNode: _focusNode,
          controller: widget.textEditingController,
          inputFormatters: widget.inputFormatter,
          style: TextStyle(
              color: widget.textColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 16.h),
            prefixIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.hintText,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: widget.labelColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            border: InputBorder.none,
            labelStyle: TextStyle(
                color: const Color(0xFF8F01DF),
                fontSize: 16.sp,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
