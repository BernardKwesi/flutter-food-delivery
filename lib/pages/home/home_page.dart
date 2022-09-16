import "package:flutter/material.dart";
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/pages/home/food_body_page.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';
import '../../utils/dimensions.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return Scaffold(
        /*   bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        ]), */
        body: Container(
            margin: EdgeInsets.only(
                top: Dimensions.height10, bottom: Dimensions.height10),
            //padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 45, bottom: 15),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(text: "Ghana", size: 23),
                            Row(
                              children: [
                                SmallText(
                                    text: 'Accra',
                                    color: Colors.black54,
                                    size: 17),
                                Icon(Icons.arrow_drop_down_outlined,
                                    color: Colors.black87, size: 20)
                              ],
                            )
                          ],
                        ),
                        Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            color: AppColor.mainColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:
                              Icon(Icons.search, color: Colors.white, size: 25),
                        )
                      ]),
                ),
                //SizedBox(height: 20),

                Expanded(
                  child: SingleChildScrollView(
                      child: Container(child: FoodBodyPage())),
                )
              ],
            )));
  }
}
