import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/models/product.dart';
import 'package:food_delivery/pages/food/popular_food_details.dart';
import 'package:food_delivery/pages/food/recommended_food_details.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import '../../utils/colors.dart';
import 'package:dots_indicator/dots_indicator.dart';
import '../../utils/dimensions.dart';
import "package:get/get.dart";

class FoodBodyPage extends StatefulWidget {
  FoodBodyPage({Key? key}) : super(key: key);

  @override
  State<FoodBodyPage> createState() => _FoodBodyPageState();
}

class _FoodBodyPageState extends State<FoodBodyPage> {
  PageController pageController = PageController(viewportFraction: 0.9);
  var _currPageValue = 0.0;
  var _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
        print("Current value is " + _currPageValue.toString());
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? Container(
                  padding: EdgeInsets.only(
                    top: Dimensions.height10,
                  ),
                  height: Dimensions.foodBodyContainer,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: popularProducts.popularProductList.length,
                    itemBuilder: (context, position) {
                      return _buildPageItem(position,
                          popularProducts.popularProductList[position]);
                    },
                  ),
                )
              : CircularProgressIndicator(color: AppColor.mainColor);
        }),
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: AppColor.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        SizedBox(height: Dimensions.height10),
        Container(
          padding: EdgeInsets.only(
              left: Dimensions.height20, right: Dimensions.height20),
          child: Row(crossAxisAlignment: CrossAxisAlignment.end,
              //mainAxisAlignment: MainAxisAlignment.,
              children: [
                BigText(text: "Recommended", color: Colors.black),
                SizedBox(width: Dimensions.height10 / 2),
                Container(
                    padding: EdgeInsets.only(bottom: 3),
                    child: BigText(text: ".", color: Colors.black54)),
                SizedBox(width: Dimensions.height10 / 2),
                Container(
                    padding: EdgeInsets.only(bottom: 2),
                    child: SmallText(text: "Food pairing")),
              ]),
        ),
        GetBuilder<RecommendedProductController>(
            builder: (recommendedProducts) {
          return recommendedProducts.isLoaded
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recommendedProducts.recommendedProductList.length,
                  itemBuilder: (context, position) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getRecommendedFood(position));
                      },
                      child: Container(
                          margin: EdgeInsets.only(
                              left: Dimensions.height20,
                              right: Dimensions.height20,
                              bottom: Dimensions.height10),
                          child: Row(children: [
                            Container(
                              width: Dimensions.height120,
                              height: Dimensions.height120,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                image: DecorationImage(
                                  image: NetworkImage(AppConstants.BASE_URL +
                                      AppConstants.UPLOAD +
                                      recommendedProducts
                                          .recommendedProductList[position]
                                          .img!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(
                                      top: Dimensions.height10,
                                      bottom: Dimensions.height10),
                                  padding: EdgeInsets.only(
                                      left: Dimensions.height10,
                                      top: Dimensions.height10),
                                  height: Dimensions.height100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight:
                                          Radius.circular(Dimensions.radius20),
                                      bottomRight:
                                          Radius.circular(Dimensions.radius20),
                                    ),
                                  ),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BigText(
                                            text: recommendedProducts
                                                .recommendedProductList[
                                                    position]
                                                .name!,
                                            color: Colors.black),
                                        SizedBox(height: Dimensions.height10),
                                        SmallText(
                                          text: recommendedProducts
                                              .recommendedProductList[position]
                                              .description,
                                        ),
                                        SizedBox(height: Dimensions.height10),
                                        Row(
                                          //crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconAndText(
                                                icon: Icons.circle_sharp,
                                                text: "Normal",
                                                iconColor: AppColor.iconColor1),
                                            SizedBox(
                                                width: Dimensions.height20),
                                            IconAndText(
                                                icon: Icons.location_on,
                                                text: "17km",
                                                iconColor: AppColor.mainColor),
                                            SizedBox(
                                                width: Dimensions.height20),
                                            IconAndText(
                                                icon: Icons.access_time_rounded,
                                                text: "32min",
                                                iconColor: AppColor.iconColor2),
                                            Expanded(
                                              child: Container(),
                                            ),
                                            SizedBox(
                                                height: Dimensions.height10)
                                          ],
                                        ),
                                      ])),
                            )
                          ])),
                    );
                  },
                )
              : CircularProgressIndicator(color: AppColor.mainColor);
        }),
        SizedBox(height: Dimensions.height10)
      ],
    );
  }

  Widget _buildPageItem(int position, Products popularProduct) {
    Matrix4 matrix = new Matrix4.identity();

    if (position == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - position) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (position == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - position + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (position == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - position) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 0)
        ..setTranslationRaw(0, currTrans, 0);
    }

    return Transform(
      transform: matrix,
      child: GestureDetector(
        onTap: () {
          Get.toNamed(RouteHelper.getPopularFood(position));
        },
        child: Stack(children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: _height,
              margin: EdgeInsets.only(
                  right: Dimensions.margin5, left: Dimensions.margin5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color:
                      position.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                  image: DecorationImage(
                      image: NetworkImage(AppConstants.BASE_URL +
                          AppConstants.UPLOAD +
                          popularProduct.img!),
                      fit: BoxFit.cover))),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageTextContainer,
              margin: EdgeInsets.only(
                  right: Dimensions.textPadding,
                  left: Dimensions.textPadding,
                  bottom: Dimensions.textPadding),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      offset: Offset(0, 5),
                      blurRadius: 5.0,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    )
                  ]),
              child: Container(
                  padding: EdgeInsets.only(
                      left: Dimensions.height15,
                      right: Dimensions.height15,
                      bottom: Dimensions.height10,
                      top: Dimensions.height15),
                  child: AppColumn(
                      text: popularProduct.name!,
                      stars: popularProduct.stars!)),
            ),
          )
        ]),
      ),
    );
  }
}
