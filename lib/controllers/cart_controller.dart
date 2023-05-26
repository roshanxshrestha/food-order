import 'dart:developer';

import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:food_delivery/models/popular_products_model.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};

  void addItem(ProductModel product, int quantity) {
    // log("length of item is " + _items.length.toString());
    _items.putIfAbsent(
      product.id!,
      () {
        log("adding items to cart " +
            product.id!.toString() +
            "quanttity" +
            quantity.toString());
        _items.forEach((key, value) {
          log("quantity is " + value.quantity.toString());
        });
        return CartModel(
          id: product.id,
          name: product.name,
          price: product.price,
          img: product.img,
          quantity: quantity,
          isExist: true,
          time: DateTime.now().toString(),
        );
      },
    );
  }
}
