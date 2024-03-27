import 'package:flutter/material.dart';

import '../../utils/size_config.dart';

class ButtonView extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;
  final Widget? prefixIcon, suffixIcon;
  final double? height, width, widthSuffix, widthPrefix, marginVertical;
  final EdgeInsetsGeometry? contentPadding;
  final bool isSecondaryColor, isOutlined, heightWrapContent, disabled;
  final Color? backgroundColor, textColor, borderColor, disabledBgColor;
  final MainAxisAlignment? mainAxisAlignmentContent;
  final _widthBtn = SizeConfig.width * .9;
  final _heightBtn = SizeConfig.height * .07;
  final FontWeight textWeight;
  final TextAlign textAlign;
  final double? textSize, sizeBorderRadius;
  final int? maxLines;

  ButtonView(
      {Key? key,
      required this.name,
      required this.onPressed,
      this.prefixIcon,
      this.suffixIcon,
      this.height,
      this.width,
      this.widthSuffix,
      this.widthPrefix,
      this.marginVertical,
      this.contentPadding,
      this.isSecondaryColor = false,
      this.isOutlined = false,
      this.heightWrapContent = false,
      this.disabled = false,
      this.backgroundColor,
      this.textColor,
      this.borderColor,
      this.disabledBgColor,
      this.mainAxisAlignmentContent,
      this.textWeight = FontWeight.bold,
      this.textAlign = TextAlign.center,
      this.textSize,
      this.sizeBorderRadius,
      this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final widthSuffix =
        this.widthSuffix ?? (heightWrapContent ? width! / 4.7 : _widthBtn / 16);
    final widthPrefix =
        this.widthPrefix ?? (heightWrapContent ? width! / 4.7 : _widthBtn / 16);
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: marginVertical ?? 24.0),
        width: width ?? _widthBtn,
        height: heightWrapContent ? null : height ?? _heightBtn,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor:
                disabledBgColor ?? (isOutlined ? Colors.white : color.surface),
            padding: contentPadding,
            backgroundColor: backgroundColor ??
                (isOutlined
                    ? Colors.white
                    : isSecondaryColor
                        ? Colors.grey
                        : Colors.orangeAccent),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(sizeBorderRadius ?? 48),
              side: isOutlined
                  ? BorderSide(
                      color: borderColor ??
                          (disabled
                              ? color.surface
                              : isSecondaryColor
                                  ? Colors.grey
                                  : Colors.orangeAccent),
                    )
                  : BorderSide.none,
            ),
          ),
          onPressed: disabled ? null : onPressed,
          child: Row(
            mainAxisAlignment: mainAxisAlignmentContent ??
                (prefixIcon != null
                    ? MainAxisAlignment.center
                    : suffixIcon != null
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.center),
            children: [
              if (prefixIcon != null) ...[
                prefixIcon!,
                SizedBox(width: widthPrefix),
              ] else
                Container(),
              Flexible(
                child: Text(
                  name,
                  textAlign: textAlign,
                  maxLines: maxLines,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: textSize ?? 20,
                    fontWeight: textWeight,
                    color: textColor ??
                        (disabled && isOutlined
                            ? color.primary
                            : disabled
                                ? Colors.white
                                : isOutlined && isSecondaryColor
                                    ? Colors.black
                                    : isOutlined
                                        ? color.primary
                                        : isSecondaryColor
                                            ? Colors.white
                                            : Colors.white),
                  ),
                ),
              ),
              if (suffixIcon != null) ...[
                SizedBox(width: widthSuffix),
                suffixIcon!
              ] else
                Container()
            ],
          ),
        ),
      ),
    );
  }
}
