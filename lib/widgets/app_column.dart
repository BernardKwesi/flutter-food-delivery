import "package:flutter/material.dart";
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text.dart';
import 'package:food_delivery/widgets/small_text.dart';

import '../utils/dimensions.dart';

class AppColumn extends StatelessWidget {
  final String text;
  final double size;
  final int stars;
  const AppColumn(
      {Key? key, required this.text, this.size = 0, required this.stars})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      BigText(text: text, color: Colors.black, size: size),
      SizedBox(height: Dimensions.height10),
      Row(children: [
        Wrap(
          children: List.generate(
            stars,
            (index) => Icon(Icons.star,
                size: Dimensions.icon15, color: AppColor.mainColor),
          ),
        ),
        SizedBox(width: Dimensions.height10),
        SmallText(text: "4.5"),
        SizedBox(width: Dimensions.height10),
        SmallText(text: "1287 comments"),
      ]),
      SizedBox(height: Dimensions.height15),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconAndText(
              icon: Icons.circle_sharp,
              text: "Normal",
              iconColor: AppColor.iconColor1),
          SizedBox(width: 20),
          IconAndText(
              icon: Icons.location_on,
              text: "17km",
              iconColor: AppColor.mainColor),
          SizedBox(width: 20),
          IconAndText(
              icon: Icons.access_time_rounded,
              text: "32min",
              iconColor: AppColor.iconColor2),
        ],
      )
    ]);
  }
}
