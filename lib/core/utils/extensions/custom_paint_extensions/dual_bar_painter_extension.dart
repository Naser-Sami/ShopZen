import 'package:flutter/material.dart';

class DualBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double cornerRadius = size.height / 2;
    const double gapWidth = 4.0; // Width of the gap between Spending and Saving sections
    // Paint for the filled "Spending" section
    final paintSpending = Paint()
      ..color = Colors.teal[800]!
      ..style = PaintingStyle.fill;

    // Paint for the "Saving" section background
    final paintSaving = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Paint for the border
    final paintBorder = Paint()
      ..color = Colors.teal[800]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw the entire Saving background
    final rRect = RRect.fromLTRBR(
      0,
      0,
      size.width,
      size.height,
      Radius.circular(cornerRadius),
    );
    canvas.drawRRect(rRect, paintSaving);

    // Draw the Spending section
    final spendingWidth = (size.width - gapWidth) / 2;
    final spendingRect = Rect.fromLTWH(0, 0, spendingWidth, size.height);
    final spendingRRect = RRect.fromRectAndCorners(spendingRect,
        topLeft: Radius.circular(cornerRadius),
        bottomLeft: Radius.circular(cornerRadius),
        bottomRight: Radius.circular(cornerRadius * 2));
    canvas.drawRRect(spendingRRect, paintSpending);

    // Draw the border with modifications
    Path path = Path();

    // Start from the top-right corner of the Spending section
    path.moveTo(spendingWidth, 1);

    // Top side of the Saving section
    path.lineTo(size.width - cornerRadius, 1);
    path.arcToPoint(
      Offset(size.width, cornerRadius),
      radius: Radius.circular(cornerRadius),
    );

    // Right side of the Saving section
    path.lineTo(size.width, size.height - cornerRadius);

    // Bottom side of the Saving section (shortened)
    path.arcToPoint(
      Offset(size.width - cornerRadius, size.height - 1),
      radius: Radius.circular(cornerRadius),
    );

    // *****
    // Change the x number to control the space
    // *****
    path.lineTo(spendingWidth + gapWidth, size.height - 1); // Shortened bottom

    // Draw the border
    canvas.drawPath(path, paintBorder);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
