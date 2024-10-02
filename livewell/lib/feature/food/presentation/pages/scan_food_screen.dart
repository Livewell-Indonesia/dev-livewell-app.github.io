// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';


// class ScanFoodScreen extends StatefulWidget {
//   const ScanFoodScreen({Key? key}) : super(key: key);

//   @override
//   State<ScanFoodScreen> createState() => _ScanFoodScreenState();
// }

// class _ScanFoodScreenState extends State<ScanFoodScreen> {
//   late CameraController _controller;
//   final ImagePicker _picker = ImagePicker();
//   @override
//   void initState() {
//     super.initState();
//     _controller = CameraController(cameras[0], ResolutionPreset.high);
//     _controller.initialize().then((value) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {});
//     }).catchError((e) {
//       if (e is CameraException) {
//         switch (e.code) {
//           case 'CameraAccessDenied':
//             break;
//           default:
//             break;
//         }
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LiveWellScaffold(
//         title: "Scan Food".tr,
//         body: Column(
//           children: [
//             20.verticalSpace,
//             _controller.value.isInitialized
//                 ? SizedBox(
//                     width: 1.sw,
//                     height: 500.h,
//                     child: Stack(
//                       fit: StackFit.expand,
//                       children: [
//                         Positioned(
//                             bottom: 0,
//                             top: 0,
//                             left: 0,
//                             right: 0,
//                             child: CameraPreview(_controller)),
//                         Align(
//                           alignment: Alignment.bottomCenter,
//                           child: Row(
//                             children: [
//                               const SizedBox(
//                                 height: 60,
//                                 width: 60,
//                               ),
//                               const Spacer(),
//                               InkWell(
//                                 onTap: () async {
//                                   try {
//                                     await _controller.takePicture();
//                                   } catch (e) {
//                                     Get.snackbar(
//                                         "Failed", 'Failed to take picture: $e');
//                                   }
//                                 },
//                                 child: const Stack(
//                                   alignment: Alignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.circle,
//                                       color: Colors.white38,
//                                       size: 80,
//                                     ),
//                                     Icon(
//                                       Icons.circle,
//                                       color: Colors.white,
//                                       size: 65,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const Spacer(),
//                               InkWell(
//                                 onTap: () async {
//                                   try {
//                                     await _picker.pickImage(
//                                         source: ImageSource.gallery);
//                                   } catch (e) {
//                                     Get.snackbar(
//                                         "Failed", 'Failed to take picture: $e');
//                                   }
//                                 },
//                                 child: const Icon(
//                                   Icons.image,
//                                   size: 60,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ))
//                 : Container(),
//             20.verticalSpace,
//             Text(
//               'Processing...'.tr,
//               style: TextStyle(
//                   color: const Color(0xFF171433),
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.w600),
//             ),
//             7.verticalSpace,
//             Text(
//               'We’ll redirect you to another screen once we got the scanning result'
//                   .tr,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 13.sp,
//                 color: const Color(0xFF171433),
//               ),
//             )
//           ],
//         ));
//   }
// }
