import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
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
          // -----------------------------------------------------
          // BACK BUTTON
          // -----------------------------------------------------
          if (showBackButton)
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, size: 20, color: Colors.black),
                onPressed: onBack ?? () => Navigator.pop(context),
                padding: EdgeInsets.zero,
              ),
            ),

          if (showBackButton) const SizedBox(width: 12),

          // -----------------------------------------------------
          // LOGO
          // -----------------------------------------------------
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary, // ORANGE BG LIKE IMAGE
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              AppStrings.startupLogo,
              height: 30,
              width: 30,
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(width: 12),

          // -----------------------------------------------------
          // TITLE + SUBTITLE
          // -----------------------------------------------------
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "GoBus",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
              Text(
                "Travel made simple",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  height: 1.1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
