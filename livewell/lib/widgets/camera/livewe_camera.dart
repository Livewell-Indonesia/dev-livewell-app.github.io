import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:livewell/main.dart';

class LiveWellCamera extends StatefulWidget {
  const LiveWellCamera({Key? key}) : super(key: key);

  @override
  State<LiveWellCamera> createState() => _LiveWellCameraState();
}

class _LiveWellCameraState extends State<LiveWellCamera> {
  late CameraController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(cameras[0], ResolutionPreset.high);
    _controller.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 500.h,
      alignment: Alignment.center,
      child: _controller.value.isInitialized
          ? CameraPreview(_controller)
          : Container(),
    );
  }
}
