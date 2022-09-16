import "package:flutter/material.dart";
import "../utils/dimensions.dart";

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final double size;

  AppIcon(
      {Key? key,
      required this.icon,
      this.iconColor = const Color(0xFF756d54),
      this.backgroundColor = const Color(0xFFfcf4e4),
      this.size = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size == 0 ? Dimensions.height45 : size,
        height: size == 0 ? Dimensions.height45 : size,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(Dimensions.height45 / 2),
        ),
        child: Icon(icon, color: iconColor, size: Dimensions.icon15));
  }
}
