import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/dimensions.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overFlow;

  BigText(
      {Key? key,
      this.color = const Color(0xFF89dad0),
      required this.text,
      this.overFlow = TextOverflow.ellipsis,
      this.size = 0})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overFlow,
      style: GoogleFonts.roboto(
          color: color,
          fontSize: size == 0 ? Dimensions.font23 : size,
          fontWeight: FontWeight.w400),
    );
  }
}
