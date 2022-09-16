import 'package:flutter/material.dart';
import "package:food_delivery/data/respository/cart_repo.dart";
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/product.dart';
import 'package:food_delivery/utils/colors.dart';
import "package:get/get.dart";

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, Cart> _items = {};

  void addItem(Products product, int quantity) {
    var totalQuantity = 0;

    if (_items.containsKey(product.id)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return Cart(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now.toString(),
        );
      });

      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          return Cart(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now.toString(),
          );
        });
      } else {
        Get.snackbar(
          "Item Count",
          "Add an Item before adding to Cart",
          colorText: Colors.white,
          backgroundColor: AppColor.mainColor.withOpacity(0.8),
          barBlur: 0.2,
        );
      }
    }
    update();
  }

  bool existInCart(Products product) {
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(Products product) {
    int quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }

    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<Cart> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }
}
