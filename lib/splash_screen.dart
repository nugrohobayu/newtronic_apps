import 'package:flutter/material.dart';
import 'package:newtronic_apps/view/home_view.dart';

import 'components/image_view/image_view.dart';
import 'utils/path_assets.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/SplashScreen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.pushNamed(context, HomeView.routeName);
    });
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
