import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/core/helper/tracker/livewell_tracker.dart';
import 'package:livewell/feature/profile/presentation/controller/account_settings_controller.dart';
import 'package:livewell/feature/profile/presentation/controller/physical_information_controller.dart';
import 'package:livewell/feature/profile/presentation/controller/user_settings_controller.dart';
import 'package:livewell/feature/profile/presentation/page/user_settings_screen.dart';
import 'package:livewell/feature/questionnaire/presentation/controller/questionnaire_controller.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/theme/design_system.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';

class AccountSettingsScreen extends StatefulWidget {
  AccountSettingsScreen({Key? key}) : super(key: key);

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  final AccountSettingsController controller = Get.put(AccountSettingsController());

  final UserSettingsController userController = Get.find();

  final PhysicalInformationController physicalController = Get.find();

  @override
  void initState() {
    controller.trackEvent(LivewellProfileEvent.accountSettingsPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 60.h, left: 16.w, right: 16.w),
                  height: 176.h,
                  decoration: const BoxDecoration(
                    color: Color(0xFFddf235),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(64),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          controller.localization.accountSettingsPage?.accountSettings ?? "Account Setting",
                          style: TextStyles.navbarTitle(context),
                        ),
                      ),
                      const IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.transparent,
                          )),
                    ],
                  ),
                ),
                //const Spacer(),
              ],
            ),
            Positioned(
              top: 98.h,
              child: SizedBox(
                width: 1.sw,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 150.w,
                          height: 150.h,
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), shape: BoxShape.circle),
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
                                        return ImagePickerBottomSheet(onImageSelected: (img, source) {
                                          physicalController.pickImages(img);
                                        });
                                      });
                                },
                                child: Container(
                                  width: 120.w,
                                  height: 120.h,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Obx(() {
                                    if (userController.user.value.avatarUrl != null && userController.user.value.avatarUrl!.isNotEmpty) {
                                      return CachedNetworkImage(
                                        imageUrl: userController.user.value.avatarUrl!,
                                        fit: BoxFit.cover,
                                        errorWidget: (context, error, stackTrace) {
                                          return SvgPicture.asset(
                                            (userController.user.value.gender ?? Gender.male.name).toLowerCase() == "male" ? Constant.imgMaleSVG : Constant.imgFemaleSVG,
                                          );
                                        },
                                      );
                                    } else {
                                      return SvgPicture.asset(
                                        (userController.user.value.gender ?? Gender.male.name).toLowerCase() == "male" ? Constant.imgMaleSVG : Constant.imgFemaleSVG,
                                      );
                                    }
                                  }),
                                ),
                              )),
                              Container(
                                width: 40.w,
                                height: 40.h,
                                decoration: const BoxDecoration(
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
                      ),
                      32.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          controller.localization.accountSettingsPage?.personalInformation ?? "Personal Information",
                          style: TextStyle(color: Theme.of(context).colorScheme.secondaryDarkBlue, fontSize: 20.sp, fontWeight: FontWeight.w600),
                        ),
                      ),
                      24.verticalSpace,
                      AccountSettingsTextField(
                        textEditingController: controller.firstName,
                        hintText: controller.localization.accountSettingsPage?.firstName ?? "First Name",
                      ),
                      20.verticalSpace,
                      AccountSettingsTextField(
                        textEditingController: controller.lastName,
                        hintText: controller.localization.accountSettingsPage?.lastName ?? "Last Name",
                      ),
                      20.verticalSpace,
                      AccountSettingsTextField(
                        textEditingController: controller.email,
                        hintText: controller.localization.accountSettingsPage?.emailAddress ?? "Email Address",
                        enabled: false,
                      ),
                      24.verticalSpace,
                      ListTile(
                        onTap: () {
                          controller.trackEvent(LivewellProfileEvent.accountSettingsPageChangePasswordButton);
                          AppNavigator.push(routeName: AppPages.updatePassword);
                        },
                        leading: const Icon(Icons.vpn_key_outlined),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.localization.accountSettingsPage?.changeYourPassword ?? "Change your password",
                              style: TextStyle(color: Theme.of(context).colorScheme.textLoEm, fontSize: 16.sp, fontWeight: FontWeight.w500),
                            ),
                            Text(controller.localization.accountSettingsPage?.changeYourPasswordAnytime ?? "Change Your Password Anytime",
                                style: TextStyle(color: Theme.of(context).colorScheme.textLoEm, fontSize: 10.sp, fontWeight: FontWeight.w500)),
                          ],
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded),
                      ),
                      64.verticalSpace,
                      TextButton(
                          onPressed: () {
                            controller.trackEvent(LivewellProfileEvent.accountSettingsPageDeleteAccountButton);
                            showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return CupertinoAlertDialog(
                                    title: Text(
                                      controller.localization.deleteAccountDialog?.dialogTitle ?? "Delete Account Permanently",
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                    content: Text(
                                        controller.localization.deleteAccountDialog?.dialogSubtitle ??
                                            "Your account and content will be deleted permanently. You may cancel the deletion request by logging in your account within 30 days.",
                                        style: const TextStyle(color: Colors.black)),
                                    actions: [
                                      CupertinoDialogAction(
                                        child: Text(
                                          controller.localization.deleteAccountDialog?.cancel ?? "Cancel",
                                          style: const TextStyle(color: Colors.black),
                                        ),
                                        onPressed: () {
                                          controller.trackEvent(LivewellProfileEvent.deleteAccountCancelButton);
                                          Get.back();
                                        },
                                      ),
                                      CupertinoDialogAction(
                                        child: Text(
                                          controller.localization.deleteAccountDialog?.confirm ?? "Confirm",
                                          style: const TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () {
                                          controller.trackEvent(LivewellProfileEvent.deleteAccountConfirmButton);
                                          controller.requestAccountDeletion();
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Row(
                            children: [
                              const Spacer(),
                              Text(
                                'Delete Account',
                                style: TextStyle(
                                  color: const Color(0xFFFA6F6F),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                            ],
                          )),
                      16.verticalSpace,
                      LiveWellButton(
                          label: controller.localization.accountSettingsPage?.update ?? "Update",
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
          ],
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
  final String? suffixText;
  const AccountSettingsTextField({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    this.enabled = true,
    this.inputType = TextInputType.text,
    this.textColor = const Color(0xFF8F01DF),
    this.labelColor = const Color(0xFF000000),
    this.inputFormatter = const [],
    this.suffixText,
  }) : super(key: key);

  @override
  State<AccountSettingsTextField> createState() => _AccountSettingsTextFieldState();
}

class _AccountSettingsTextFieldState extends State<AccountSettingsTextField> {
  final FocusNode _focusNode = FocusNode();

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: false,
      actions: widget.inputType == TextInputType.number || widget.inputType == const TextInputType.numberWithOptions(decimal: true)
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
          style: TextStyle(color: widget.textColor, fontSize: 16.sp, fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            suffixText: widget.suffixText,
            suffixStyle: TextStyle(color: widget.textColor, fontSize: 16.sp, fontWeight: FontWeight.w400),
            contentPadding: EdgeInsets.only(top: 16.h),
            prefixIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.hintText,
                  textAlign: TextAlign.start,
                  style: TextStyle(color: widget.labelColor, fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            border: InputBorder.none,
            labelStyle: TextStyle(color: const Color(0xFF8F01DF), fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
