import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormView extends StatelessWidget {
  final String name;
  final double nameSize;
  final String? helperText, initialValue, hintText, errorText;
  final VoidCallback? onTap;
  final bool enabled,
      readOnly,
      obscureText,
      textarea,
      isTextAlignCenter,
      disableColor;
  final TextEditingController? ctrl;
  final Widget? suffixIcon,
      suffixLabel,
      prefixIcon,
      prefix,
      trailingTitleWidget;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? errorStyle, hintTextStyle;
  final Color? enabledBorderColor, focusedBorderColor;
  final BoxConstraints? suffixIconConstraints, prefixIconConstraints;
  final Color? disabledBorderColor;
  final bool? enableInteractiveSelection;
  final Color? fontColorDisabled;
  final EdgeInsets? contentPadding;
  final FocusNode? focusNode;
  final double? borderRadius;

  // ignore: prefer_const_constructors_in_immutables
  TextFormView(
      {Key? key,
      required this.name,
      this.nameSize = 14,
      this.helperText,
      this.initialValue,
      this.onTap,
      this.enabled = true,
      this.readOnly = false,
      this.hintText,
      this.errorText,
      this.ctrl,
      this.suffixIcon,
      this.suffixLabel,
      this.prefixIcon,
      this.prefix,
      this.keyboardType,
      this.validator,
      this.obscureText = false,
      this.maxLength,
      this.onChanged,
      this.inputFormatters,
      this.errorStyle,
      this.hintTextStyle,
      this.enabledBorderColor,
      this.focusedBorderColor,
      this.textarea = false,
      this.isTextAlignCenter = false,
      this.trailingTitleWidget,
      this.suffixIconConstraints,
      this.prefixIconConstraints,
      this.disableColor = false,
      this.disabledBorderColor,
      this.enableInteractiveSelection,
      this.fontColorDisabled,
      this.contentPadding,
      this.focusNode,
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadiusCircular =
        BorderRadius.all(Radius.circular(borderRadius ?? 12));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            focusNode: focusNode,
            minLines: textarea ? 8 : 1,
            maxLines: textarea ? null : 1,
            maxLength: maxLength,
            initialValue: initialValue,
            enabled: enabled,
            controller: ctrl,
            keyboardType: keyboardType,
            onTap: onTap,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: fontColorDisabled ?? Colors.grey,
            ),
            readOnly: readOnly,
            validator: validator,
            obscureText: obscureText,
            onChanged: onChanged,
            inputFormatters: inputFormatters,
            enableInteractiveSelection: enableInteractiveSelection,
            textAlign: isTextAlignCenter ? TextAlign.center : TextAlign.left,
            decoration: InputDecoration(
                helperText: helperText,
                errorStyle: errorStyle,
                errorText: errorText,
                errorMaxLines: 2,
                hintStyle: hintTextStyle ??
                    const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                    ),
                isDense: true,
                hintText: hintText,
                filled: true,
                fillColor: enabled && disableColor == false
                    ? Colors.white
                    : Colors.white70,
                disabledBorder: OutlineInputBorder(
                  borderRadius: borderRadiusCircular,
                  borderSide: BorderSide(
                    color: disabledBorderColor ?? Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: borderRadiusCircular,
                  borderSide: BorderSide(
                    color: enabledBorderColor ?? Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: borderRadiusCircular,
                  borderSide: BorderSide(
                    color: focusedBorderColor ?? Colors.grey,
                  ),
                ),
                border: OutlineInputBorder(borderRadius: borderRadiusCircular),
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
                suffixIconConstraints: suffixIconConstraints,
                prefixIconConstraints: prefixIconConstraints,
                prefix: prefix,
                contentPadding: contentPadding ??
                    const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 16.0,
                    )),
          )
        ],
      ),
    );
  }
}
