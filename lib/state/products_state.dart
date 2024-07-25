import 'package:flutter/material.dart';

import '../models/product.dart';
import '../repositories/product_repo.dart';

class ProductsState extends ChangeNotifier {
  List<Product> products = [];

  ProductsState() {
    refreshProducts();
  }

  void refreshProducts() async {
    products = await ProductRepo.fetchProducts();
    notifyListeners();
  }

  Product getById(int productId) {
    return products.firstWhere((p) => p.id == productId);
  }
}
