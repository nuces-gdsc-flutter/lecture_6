import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/cart_item.dart';

class CartRepo {
  static const String _baseUrl = 'https://fakestoreapi.com';

  static Future<List<CartItem>> fetchCartItems(int cartId) async {
    final response = await http.get(Uri.parse('$_baseUrl/carts/$cartId'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body)['products'];
      return jsonList
          .map((json) => CartItem(
                productId: json['productId'],
                quantity: json['quantity'],
              ))
          .toList();
    } else {
      throw Exception('Failed to fetch cart items');
    }
  }

  static Future<void> updateCartItem(int cartId, CartItem item) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/carts/$cartId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'products': [item.toJson()]
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update cart item');
    }
  }

  static Future<void> deleteCartItem(int cartId, int productId) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/carts/$cartId?productId=$productId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete cart item');
    }
  }
}
