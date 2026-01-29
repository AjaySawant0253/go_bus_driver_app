import 'package:flutter/material.dart';
import '../constants/app_strings.dart';

class GoBusHeader extends StatelessWidget {
  final bool showBackButton;
  final VoidCallback? onBack;
  final double paddingTop;
  final double paddingBottom;

  const GoBusHeader({
    super.key,
    this.showBackButton = false,
    this.onBack,
    this.paddingTop = 16,
    this.paddingBottom = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: paddingTop,
        bottom: paddingBottom,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Back Button (Optional)
          if (showBackButton)
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 24,
                color: Colors.black,
              ),
              onPressed: onBack ?? () => Navigator.pop(context),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),

          if (showBackButton) const SizedBox(width: 12),

          /// Logo Image Only (No Box, No Text)
          Image.asset(
            AppStrings.startupLogo,
            height: 36,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
