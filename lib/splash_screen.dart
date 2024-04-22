import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:newtronic_apps/view/home_view.dart';
import 'package:permission_handler/permission_handler.dart';

import 'components/image_view/image_view.dart';
import 'utils/path_assets.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/SplashScreen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<bool> checkStoragePermission() async {
    if (Platform.isAndroid) {
      final plugin = DeviceInfoPlugin();
      final android = await plugin.androidInfo;
      final permissionStorage = await Permission.storage.status;
      final permissionPhotos = await Permission.photos.status;

      if (android.version.sdkInt! < 33) {
        if (permissionStorage.isDenied) {
          await Permission.storage.request();
        }
        return permissionStorage.isGranted;
      } else {
        if (permissionPhotos.isDenied) {
          await Permission.photos.request();
        }
        return permissionPhotos.isGranted;
      }
    } else {
      return true;
    }
  }

  Future initS() async {
    await checkStoragePermission();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.pushNamed(context, HomeView.routeName);
    });
  }

  @override
  void initState() {
    initS();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ImageView(
              image: PathAssets.imgLogo,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
