import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode; // Added FocusNode
  final String? labelText;
  final String? hintText;
  final String? errorText;
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
  final bool autofocus; // Added autofocus

  const CustomTextFormField({
    super.key,
    this.controller,
    this.focusNode, // Added to constructor
    this.labelText,
    this.hintText,
    this.errorText,
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
    this.autofocus = false, // Added to constructor
  });

  @override
  Widget build(BuildContext context) {
    // Calculate optimal content padding based on whether there's a label
    final defaultContentPadding = labelText != null
        ? const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
        : const EdgeInsets.symmetric(horizontal: 0, vertical: 16);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label outside the text field for better alignment control
        if (labelText != null) ...[
          Text(
            labelText!,
            style: labelStyle ?? TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
        ],
        
        // Text Field with consistent internal alignment
        TextFormField(
          controller: controller,
          focusNode: focusNode, // Added focusNode
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          validator: validator,
          enabled: enabled,
          maxLines: maxLines,
          maxLength: maxLength,
          autofocus: autofocus, // Added autofocus
          style: textStyle ?? TextStyle(
            fontSize: 16, 
            color: Colors.black87,
            height: 1.2,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            errorText: errorText,
            prefixIcon: prefixIcon != null 
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: prefixIcon,
                  )
                : null,
            suffixIcon: suffixIcon != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: suffixIcon,
                  )
                : null,
            filled: filled,
            fillColor: fillColor,
            contentPadding: contentPadding ?? defaultContentPadding,
            isDense: true,
            
            // Border styling - now uses focusNode to determine focused state
            border: hasBorder ? OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(color: borderColor, width: borderWidth),
            ) : InputBorder.none,
            
            enabledBorder: hasBorder ? OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(color: borderColor, width: borderWidth),
            ) : InputBorder.none,
            
            focusedBorder: hasBorder ? OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(color: focusedBorderColor, width: borderWidth),
            ) : InputBorder.none,
            
            errorBorder: hasBorder ? OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(color: Colors.red, width: borderWidth),
            ) : InputBorder.none,
            
            focusedErrorBorder: hasBorder ? OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(color: Colors.red, width: borderWidth),
            ) : InputBorder.none,
            
            disabledBorder: hasBorder ? OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(color: Colors.grey.shade300, width: borderWidth),
            ) : InputBorder.none,
            
            hintStyle: hintStyle ?? TextStyle(
              color: Colors.grey.shade500,
              fontSize: 16,
              height: 1.2,
            ),
            alignLabelWithHint: true,
          ),
        ),
      ],
    );
  }
}