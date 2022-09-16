import "package:flutter/material.dart";
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_small_text.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';

import 'package:get/get.dart';

class RecommendedFoodDetails extends StatelessWidget {
  final int pageId;
  const RecommendedFoodDetails({Key? key, required this.pageId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
        bottomNavigationBar:
            GetBuilder<PopularProductController>(builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height10,
                      right: Dimensions.height20 * 2.5,
                      left: Dimensions.height20 * 2.5,
                      bottom: Dimensions.height10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.setQuantity(false);
                        },
                        child: AppIcon(
                            icon: Icons.remove,
                            backgroundColor: AppColor.mainColor,
                            iconColor: Colors.white),
                      ),
                      BigText(
                          text: "\$" +
                              product.price.toString() +
                              " X ${controller.inCartItems} ",
                          color: Colors.black,
                          size: Dimensions.font30),
                      GestureDetector(
                        onTap: () {
                          controller.setQuantity(true);
                        },
                        child: AppIcon(
                            icon: Icons.add,
                            backgroundColor: AppColor.mainColor,
                            iconColor: Colors.white),
                      ),
                    ],
                  )),
              Container(
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
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: AppColor.mainColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.addItem(product);
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
                            text: "\$ " +
                                product.price.toString() +
                                "  Add to cart",
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  )),
            ],
          );
        }),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: Dimensions.height90,
              title: Container(
                //margin: EdgeInsets.only(top: 60),
                padding: EdgeInsets.only(
                    top: Dimensions.height10, bottom: Dimensions.height15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: AppIcon(icon: Icons.clear)),
                    GestureDetector(
                      onTap: () {
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
                    ),
                  ],
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(Dimensions.height20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.radius20),
                          topRight: Radius.circular(Dimensions.radius20))),
                  padding: EdgeInsets.only(
                      top: Dimensions.height10, bottom: Dimensions.height10),
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: BigText(
                      text: product.name,
                      color: AppColor.mainBlackColor,
                      size: Dimensions.font30,
                    ),
                  ),
                ),
              ),
              pinned: true,
              backgroundColor: AppColor.yellowColor,
              expandedHeight: Dimensions.height300,
              flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                AppConstants.BASE_URL + AppConstants.UPLOAD + product.img!,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              )),
            ),
            SliverToBoxAdapter(
                child: Container(
              padding: EdgeInsets.only(
                  right: Dimensions.height20, left: Dimensions.height20),
              margin: EdgeInsets.only(
                  top: Dimensions.height10, bottom: Dimensions.height10),
              child: SmallText(height: 1.4, text: product.description),
            ))
          ],
        ));
  }
}
