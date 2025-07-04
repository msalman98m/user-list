// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:userlist/theme/theme_extension.dart';

class CustomTextFieldWithLabel extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String hintText;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final int? minLines;
  final int? maxLength;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatter;
  final Function? onTap;
  final Function? onChanged;
  final Function? validator;
  final bool enabled;
  final Widget? widget;
  final TextCapitalization textCapitalization;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextAlign textAlign;
  final double labelFS;
  final double hintFS;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final bool optional;
  final Color labelColor;
  final Color hintColor;
  final Color? borderColor;
  final Color? textColor;
  final String? counterText;
  final String? initValue;
  final bool filled;

  const CustomTextFieldWithLabel({
    super.key,
    this.label,
    this.controller,
    this.focusNode,
    this.minLines,
    this.maxLength,
    this.maxLines,
    required this.hintText,
    this.inputType = TextInputType.text,
    this.inputFormatter,
    this.onTap,
    this.onChanged,
    this.validator,
    this.inputAction = TextInputAction.done,
    this.enabled = true,
    this.widget,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.prefixIconConstraints,
    this.prefixIcon,
    this.textAlign = TextAlign.start,
    this.textCapitalization = TextCapitalization.none,
    this.labelFS = 14,
    this.hintFS = 16,
    this.optional = false,
    this.labelColor = const Color(0xFF3E3E3E),
    this.borderColor,
    this.counterText = '',
    this.hintColor = const Color(0xFFAAABB5),
    this.textColor = Colors.black,
    this.initValue,
    this.filled = false,
  });

  textFormBorder(context) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        // color: borderColor ?? themeColor,
        color: borderColor ?? const Color(0XFF85A6D8),
      ),
      borderRadius: BorderRadius.circular(4),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double tS = MediaQuery.of(context).textScaleFactor;
    final double dW = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (label != '')
              Row(
                children: [
                  // TextWidget(
                  //   title: label,
                  //   fontSize: labelFS,
                  //   color: labelColor,
                  //   fontWeight: FontWeight.w500,
                  // ),

                  if (label != null) ...[
                    Text(
                      label!,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: tS * 12,
                            color: const Color(0xff84858E),
                          ),
                    ),
                  ],
                  if (label != null) ...[
                    if (!optional)
                      Text(
                        '*',
                        style: TextStyle(
                          fontSize: labelFS,
                          color: const Color(0xFFDD4F4D),
                        ),
                      ),
                  ]
                ],
              ),
            if (widget != null) widget!,
          ],
        ),
        if (label != '') SizedBox(height: dW * 0.025),
        TextFormField(
          controller: controller,
          initialValue: initValue,
          focusNode: focusNode,
          onTap: onTap != null ? () => onTap!() : null,
          inputFormatters: inputFormatter,
          textCapitalization: textCapitalization,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          enabled: enabled,
          textAlign: textAlign,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: tS * 14,
                color: context.colors.heading,
              ),
          cursorColor: const Color(0XFF85A6D8),
          //themeColor,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: tS * 12,
                  color: context.colors.subheading,
                ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: dW * 0.045,
              vertical: dW * 0.04,
            ),
            border: textFormBorder(context),
            focusedBorder: textFormBorder(context),
            enabledBorder: textFormBorder(context),
            errorBorder: textFormBorder(context),
            disabledBorder: textFormBorder(context),
            focusedErrorBorder: textFormBorder(context),
            counterText: counterText,
            suffixIcon: suffixIcon,
            suffixIconConstraints: suffixIconConstraints,
            prefixIcon: prefixIcon,
            prefixIconConstraints: prefixIconConstraints,
            filled: filled,
            fillColor: Colors.white,
          ),
          minLines: minLines,
          maxLength: maxLength,
          maxLines: maxLines,
          textInputAction: inputAction,
          keyboardType: inputType,
          onChanged: onChanged != null ? (value) => onChanged!(value) : null,
          validator: validator != null ? (value) => validator!(value) : null,
        ),
      ],
    );
  }
}
