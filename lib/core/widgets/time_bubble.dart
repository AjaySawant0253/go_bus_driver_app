import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_bus_driver_app/core/constants/app_colors.dart';

class DashedLineWithHours extends StatelessWidget {
  final String hours;

  const DashedLineWithHours({super.key, required this.hours});

  Widget _dash() {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              (constraints.maxWidth / 10).floor(),
              (_) => Container(
                width: 4,
                height: 2,
                color: Colors.blue.shade300,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _dash(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            hours,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        _dash(),
      ],
    );
  }
}

class TimeChatBubble extends StatelessWidget {
  final String text;
  final double width;

  const TimeChatBubble({
    super.key,
    required this.text,
    this.width = 100, // 👈 increase width here
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: CustomPaint(
        painter: _BubblePainter(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget bubbleWithLabel(String label, String time) {
  return Column(
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 6),
      TimeChatBubble(text: time),
    ],
  );
}

Widget timelineRow(String hours) {
  Widget dash() {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              (constraints.maxWidth / 10).floor(),
              (_) => Container(
                width: 4,
                height: 2,
                color: Colors.blue.shade300,
              ),
            ),
          );
        },
      ),
    );
  }

  return Row(
    children: [
      // LEFT DOT
      Container(
        width: 10,
        height: 10,
        decoration: const BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
      ),

      const SizedBox(width: 6),
      dash(),
      const SizedBox(width: 8),

      // HOURS
      Text(
        hours,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),

      const SizedBox(width: 8),
      dash(),
      const SizedBox(width: 6),

      // RIGHT DOT
      Container(
        width: 10,
        height: 10,
        decoration: const BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
      ),
    ],
  );
}

class _BubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE3F0FF)
      ..style = PaintingStyle.fill;

    final path = Path();

    const radius = 12.0;
    const notchWidth = 12.0;
    const notchHeight = 8.0;

    path.moveTo(radius, 0);
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);
    path.lineTo(size.width, size.height - notchHeight - radius);
    path.quadraticBezierTo(
      size.width,
      size.height - notchHeight,
      size.width - radius,
      size.height - notchHeight,
    );

    // Notch (center)
    path.lineTo(size.width / 2 + notchWidth / 2, size.height - notchHeight);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width / 2 - notchWidth / 2, size.height - notchHeight);

    path.lineTo(radius, size.height - notchHeight);
    path.quadraticBezierTo(
      0,
      size.height - notchHeight,
      0,
      size.height - notchHeight - radius,
    );
    path.lineTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

