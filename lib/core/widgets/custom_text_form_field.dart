import 'package:flutter/material.dart';
import 'package:go_bus_driver_app/core/constants/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? labelText;
  final String? hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final int maxLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool hasBorder;
  final Color borderColor;
  final Color focusedBorderColor;
  final double borderWidth;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final Color? fillColor;
  final bool filled;
  final BorderRadius borderRadius;
  final bool autofocus;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.focusNode,
    this.labelText,
    this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.hasBorder = true,
    this.borderColor = Colors.grey,
    this.focusedBorderColor = Colors.blue,
    this.borderWidth = 1.0,
    this.contentPadding,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
    this.fillColor,
    this.filled = false,
    this.borderRadius = BorderRadius.zero,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    final defaultContentPadding = labelText != null
        ? const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
        : const EdgeInsets.symmetric(horizontal: 0, vertical: 16);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style: labelStyle ??
                TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          enabled: enabled,
          maxLines: maxLines,
          maxLength: maxLength,
          autofocus: autofocus,
          style: textStyle ??
              const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            filled: filled,
            fillColor: fillColor,
            contentPadding: contentPadding ?? defaultContentPadding,
            isDense: true,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 1.5,
              ),
            ),
            focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 1.5,
              ),
            ),
            errorStyle: const TextStyle(
              fontSize: 12,
              color: Colors.red,
            ),
            errorMaxLines: 2,
          ),
        ),
      ],
    );
  }
}
