import 'package:flutter/material.dart';

import '../../utils/path_assets.dart';
import '../../utils/size_config.dart';
import '../button/button_view.dart';
import '../image_view/image_view.dart';

class DialogView {
  static Future warning(BuildContext context,
      {double? height,
      required String description,
      required VoidCallback onPressedOk}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          content: SizedBox(
            height: height ?? SizeConfig.height * .3,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ImageView(
                    image: PathAssets.icWarning,
                    width: SizeConfig.width * .3,
                  ),
                ),
                Expanded(
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ButtonView(
              name: 'OK',
              marginVertical: 4,
              height: SizeConfig.height * .06,
              onPressed: onPressedOk,
            ),
          ],
        );
      },
    );
  }
}
