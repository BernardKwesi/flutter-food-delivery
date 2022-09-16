//import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';
import '../../utils/dimensions.dart';
import 'package:get/get.dart';
import '../../widgets/big_text.dart';
import '../../utils/colors.dart';

class PopularFoodDetails extends StatelessWidget {
  final int pageId;
  const PopularFoodDetails({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              height: Dimensions.height350,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(AppConstants.BASE_URL +
                      AppConstants.UPLOAD +
                      product.img!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.height30,
            right: Dimensions.height30,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios)),
                  GetBuilder<PopularProductController>(builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        print("Hello Cart");
                        Get.to(CartPage());
                      },
                      child: Stack(
                        children: [
                          AppIcon(icon: Icons.shopping_cart_outlined),
                          Get.find<PopularProductController>().totalItems >= 1
                              ? Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: AppColor.mainColor,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Center(
                                      child: BigText(
                                        text:
                                            Get.find<PopularProductController>()
                                                .totalItems
                                                .toString(),
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    );
                  }),
                ]),
          ),
          Positioned(
            left: 0,
            top: Dimensions.height350 - Dimensions.height30,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: Dimensions.height30,
                left: Dimensions.height20,
                right: Dimensions.height20,
              ),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius30),
                  topLeft: Radius.circular(
                    Dimensions.radius30,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(
                      stars: product.stars,
                      text: product.name,
                      size: Dimensions.font24),
                  SizedBox(height: Dimensions.height20),
                  BigText(text: "Introduce", color: Colors.black),
                  SizedBox(height: Dimensions.height10),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(text: product.description),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (popularProducts) {
        return Container(
            padding: EdgeInsets.only(
                top: Dimensions.height20,
                right: Dimensions.height20,
                left: Dimensions.height20,
                bottom: Dimensions.height20),
            height: Dimensions.height100,
            decoration: BoxDecoration(
              color: AppColor.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(Dimensions.radius20 * 2),
                topLeft: Radius.circular(Dimensions.radius20 * 2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        right: Dimensions.height20,
                        left: Dimensions.height20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              print("Minus ");
                              popularProducts.setQuantity(false);
                            },
                            child: Icon(Icons.remove)),
                        SizedBox(width: Dimensions.height10),
                        BigText(
                            text: popularProducts.inCartItems.toString(),
                            color: Colors.black54),
                        SizedBox(width: Dimensions.height10),
                        GestureDetector(
                            onTap: () {
                              popularProducts.setQuantity(true);
                            },
                            child: Icon(Icons.add)),
                      ],
                    )),
                GestureDetector(
                  onTap: () {
                    popularProducts.addItem(product);
                  },
                  child: Container(
                      padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        right: Dimensions.height20,
                        left: Dimensions.height20,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.mainColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                      ),
                      child: BigText(
                        text: "\$ " + product.price.toString() + " Add to cart",
                        color: Colors.white,
                      )),
                )
              ],
            ));
      }),
    );
  }
}
