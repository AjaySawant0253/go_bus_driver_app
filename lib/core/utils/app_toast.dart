import 'package:flutter/material.dart';

enum ToastType { success, error, info }

class AppToast {
  static void show(
    BuildContext context, {
    required String message,
    ToastType type = ToastType.info,
    Duration duration = const Duration(seconds: 2),
  }) {
    final overlay = Overlay.of(context);
    if (overlay == null) return;

    // Determine background color based on type
    Color bgColor;
    IconData iconData;
    switch (type) {
      case ToastType.success:
        bgColor = Colors.green.shade600;
        iconData = Icons.check_circle;
        break;
      case ToastType.error:
        bgColor = Colors.red.shade600;
        iconData = Icons.error;
        break;
      case ToastType.info:
      default:
        bgColor = Colors.blue.shade600;
        iconData = Icons.info;
        break;
    }

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(iconData, color: Colors.white),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Remove overlay after duration
    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }
}
