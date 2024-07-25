import 'cart_item.dart';

class Cart {
  final int id;
  final List<CartItem> items;

  Cart({
    required this.id,
    required this.items,
  });
}
