import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:newtronic_apps/utils/size_config.dart';

class ImageView extends StatelessWidget {
  final dynamic image;
  final double? height, width, borderRadius;
  final BoxFit? fit;
  final Color? loadingColor, color;
  final Widget? loadingWidget, errorWidget;

  // ignore: prefer_const_constructors_in_immutables
  ImageView({
    Key? key,
    required this.image,
    this.height,
    this.width,
    this.loadingWidget,
    this.loadingColor,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.errorWidget,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errWidget = errorWidget ??
        Icon(
          Icons.image_not_supported_outlined,
          size: fit == BoxFit.fitHeight
              ? SizeConfig.height * .2
              : SizeConfig.width * .2,
          color: Colors.grey,
        );
    if (image is String) {
      var image = this.image as String;
      if (image.isNotEmpty) {
        if (image.startsWith("https") || image.startsWith("http")) {
          if (image.endsWith(".svg")) {
            return SvgPicture.network(
              image,
              fit: BoxFit.fitWidth,
              width: width,
              height: height,
              color: color,
            );
          }
          return ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius ?? 0.0),
            child: CachedNetworkImage(
              imageUrl: image,
              width: width,
              height: height,
              fit: fit,
              color: color,
              placeholder: (context, url) {
                return loadingWidget ??
                    Center(
                      child: CircularProgressIndicator(
                        color: loadingColor,
                      ),
                    );
              },
              errorWidget: (context, _, x) {
                return errWidget;
              },
            ),
          );
        } else if (image.startsWith("assets")) {
          if (image.endsWith(".json")) {
            return LottieBuilder.asset(
              image,
              height: height,
              width: width,
            );
          }
          // handle svg from assets
          if (image.endsWith('.svg')) {
            return SvgPicture.asset(
              image,
              fit: BoxFit.fitWidth,
              width: width,
              height: height,
              color: color,
            );
          }
          return ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius ?? 0.0),
            child: Image.asset(
              image,
              height: height,
              width: width,
              fit: fit,
              color: color,
            ),
          );
        }
      }
    }
    if (image is File) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 0.0),
        child: Image.file(
          image,
          height: height,
          width: width,
          fit: fit,
          color: color,
        ),
      );
    }
    return errWidget;
  }
}
