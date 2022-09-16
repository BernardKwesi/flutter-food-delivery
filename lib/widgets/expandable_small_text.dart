import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/dimensions.dart';

class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overFlow;
  double height;

  SmallText(
      {Key? key,
      this.color = const Color(0xFFccc7c5),
      required this.text,
      this.overFlow = TextOverflow.ellipsis,
      this.size = 0,
      this.height = 1.2})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.roboto(
          color: color,
          height: height,
          fontSize: size == 0 ? Dimensions.font17 : size,
          fontWeight: FontWeight.w400),
    );
  }
}
