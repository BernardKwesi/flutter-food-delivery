import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/data/respository/popular_product_repo.dart';
import 'package:food_delivery/models/product.dart';
import 'package:get/get.dart';
import 'package:food_delivery/models/cart_model.dart';
import '../utils/colors.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int get quantity => _quantity;
  var _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;
  late CartController _cart;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();

    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);

      update();
      _isLoaded = true;
      //  print(_popularProductList);
    } else {
      print("Error");
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  void initProduct(Products product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    bool exist = false;
    exist = _cart.existInCart(product);
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }

    print("the quantity in the cart is " + _inCartItems.toString());
  }

  void addItem(Products product) {
    _cart.addItem(product, _quantity);
    update();
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar(
        "Item Count",
        "Add an Item before adding to Cart",
        colorText: Colors.white,
        backgroundColor: AppColor.mainColor.withOpacity(0.8),
        barBlur: 0.2,
      );
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar(
        "Item Count",
        "You Can't Add More ",
        colorText: Colors.white,
        backgroundColor: AppColor.mainColor.withOpacity(0.8),
        barBlur: 0.2,
      );
      return 20;
    } else {
      return quantity;
    }
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<Cart> get getItems {
    return _cart.getItems;
  }
}
