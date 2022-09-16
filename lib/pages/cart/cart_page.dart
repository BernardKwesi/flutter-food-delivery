import 'package:flutter/material.dart';
import 'package:food_delivery/pages/home/home_page.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_small_text.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../widgets/app_icon.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.buttonBackgroundColor,
        body: Stack(
          children: [
            Positioned(
              top: Dimensions.height20 * 3,
              right: Dimensions.width30,
              left: Dimensions.width30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: AppIcon(
                      backgroundColor: AppColor.mainColor,
                      icon: Icons.arrow_back_ios,
                      iconColor: Colors.white,
                    ),
                  ),
                  SizedBox(width: Dimensions.height20 * 3),
                  GestureDetector(
                    onTap: () {
                      Get.to(HomePage());
                    },
                    child: AppIcon(
                      backgroundColor: AppColor.mainColor,
                      icon: Icons.home_outlined,
                      iconColor: Colors.white,
                    ),
                  ),
                  AppIcon(
                    backgroundColor: AppColor.mainColor,
                    icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                  ),
                ],
              ),
            ),
            Positioned(
              top: Dimensions.height20 * 5,
              left: Dimensions.width30,
              right: Dimensions.width30,
              bottom: 0,
              child: Container(
                  margin: EdgeInsets.only(top: Dimensions.height20),
                  child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child:
                          GetBuilder<CartController>(builder: (cartController) {
                        return ListView.builder(
                            itemCount: cartController.getItems.length,
                            itemBuilder: (_, index) {
                              return Container(
                                  height: Dimensions.height100,
                                  width: double.maxFinite,
                                  margin: EdgeInsets.only(
                                      bottom: Dimensions.height20),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: Dimensions.height20 * 5,
                                        height: Dimensions.height20 * 5,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius20),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  AppConstants.BASE_URL +
                                                      AppConstants.UPLOAD +
                                                      cartController
                                                          .getItems[index]
                                                          .img!),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      SizedBox(width: Dimensions.height10),
                                      Expanded(
                                        child: Container(
                                          height: Dimensions.height100,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                BigText(
                                                    text: cartController
                                                        .getItems[index].name!,
                                                    color: Colors.black54),
                                                SmallText(text: "Spicy"),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    BigText(
                                                        text:
                                                            "\$ ${cartController.getItems[index].price} ",
                                                        color:
                                                            Colors.redAccent),
                                                    Container(
                                                        padding: EdgeInsets.only(
                                                            top: Dimensions
                                                                .height10,
                                                            bottom: Dimensions
                                                                .height10,
                                                            right: Dimensions
                                                                .height10,
                                                            left: Dimensions
                                                                .height10),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  Dimensions
                                                                      .radius20),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            GestureDetector(
                                                                onTap: () {
                                                                  print(
                                                                      "Minus ");
                                                                  // popularProducts.setQuantity(false);
                                                                },
                                                                child: Icon(Icons
                                                                    .remove)),
                                                            SizedBox(
                                                                width: Dimensions
                                                                    .height10),
                                                            BigText(
                                                                text:
                                                                    "0", //popularProducts.inCartItems.toString(),
                                                                color: Colors
                                                                    .black54),
                                                            SizedBox(
                                                                width: Dimensions
                                                                    .height10),
                                                            GestureDetector(
                                                                onTap: () {
                                                                  //  popularProducts.setQuantity(true);
                                                                },
                                                                child: Icon(
                                                                    Icons.add)),
                                                          ],
                                                        )),
                                                  ],
                                                )
                                              ]),
                                        ),
                                      ),
                                    ],
                                  ));
                            });
                      }))),
            )
          ],
        ));
  }
}
