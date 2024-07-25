import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '../models/product.dart';
import '../repositories/cart_repo.dart';

class CartState extends ChangeNotifier {
  List<CartItem> items = [];

  CartState() {
    refreshCart();
  }

  void refreshCart() async {
    items = await CartRepo.fetchCartItems(1);
    notifyListeners();
  }

  void addProduct(Product product) {
    final index = items.indexWhere((p) => p.productId == product.id);
    if (index >= 0) {
      increment(product.id);
    } else {
      items.add(
        CartItem(
          productId: product.id,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void increment(int productId) {
    items = [
      for (final item in items)
        if (item.productId == productId) //
          CartItem(
            productId: productId,
            quantity: item.quantity + 1,
          )
        else
          item,
    ];
    notifyListeners();
  }

  void decrement(int productId) {
    items = [
      for (final item in items)
        if (item.productId == productId && item.quantity > 0) //
          CartItem(
            productId: productId,
            quantity: item.quantity - 1,
          )
        else if (item.productId != productId)
          item,
    ];
    notifyListeners();
  }

  void deleteProduct(int productId) {
    items = [
      for (final item in items)
        if (item.productId != productId) item,
    ];
    notifyListeners();
  }
}
