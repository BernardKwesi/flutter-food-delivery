import "package:flutter/material.dart";
import 'package:food_delivery/widgets/expandable_small_text.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class ExpandableTextWidget extends StatefulWidget {
  final text;

  ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  double textHeight = Dimensions.screenHeight / 5.70;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      //  print(firstHalf);
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    //  print(firstHalf);
    return Container(
        child: secondHalf.isEmpty
            ? SmallText(
                text: firstHalf,
                height: 1.5,
              )
            : Column(children: [
                SmallText(
                    color: AppColor.paraColor,
                    height: 1.5,
                    text: hiddenText
                        ? (firstHalf + "...")
                        : firstHalf + secondHalf),
                SizedBox(height: Dimensions.height10),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: hiddenText
                      ? Row(
                          children: [
                            SmallText(
                              color: AppColor.mainColor,
                              text: "Show more",
                            ),
                            Icon(Icons.arrow_drop_down,
                                color: AppColor.mainColor),
                          ],
                        )
                      : Row(
                          children: [
                            SmallText(
                                text: "Show less", color: AppColor.mainColor),
                            Icon(Icons.arrow_drop_up,
                                color: AppColor.mainColor),
                          ],
                        ),
                )
              ]));
  }
}
