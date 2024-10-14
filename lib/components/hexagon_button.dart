import 'package:flutter/material.dart';
import 'package:pathly/constants/hexagon_button_constants.dart';


// PrimaryButton widget
class HexagonButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? buttonColor;
  final TextStyle? textStyle;

  HexagonButton({
    required this.onPressed,
    required this.text,
    this.buttonColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HexagonClipper(),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor, // Use passed buttonColor or default
          padding: kHexagonButtonPadding, // Constant for padding
          shape: const RoundedRectangleBorder(),
        ),
        child: Text(
          text,
          style: textStyle, // Use passed textStyle or default
        ),
      ),
    );
  }
}

// HexagonClipper class (No constants required here)
class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double w = size.width;
    double h = size.height;

    // Define points for the hexagon shape
    path.moveTo(w * 0.1, 0); // Start point (top left)
    path.lineTo(w * 0.9, 0); // Top edge
    path.lineTo(w, h * 0.5); // Top-right diagonal edge
    path.lineTo(w * 0.9, h); // Right edge
    path.lineTo(w * 0.1, h); // Bottom edge
    path.lineTo(0, h * 0.5); // Bottom-left diagonal edge
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
