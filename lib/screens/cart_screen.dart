import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/cart_state.dart';
import '../state/products_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartState = context.watch<CartState>();
    final items = cartState.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: ListView.separated(
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          final item = items[index];
          final product = context.watch<ProductsState>().getById(item.productId);

          return ListTile(
            leading: Hero(
              tag: product.id,
              child: Image.network(
                product.image,
              ),
            ),
            title: Text(
              product.title,
              maxLines: 1,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => cartState.decrement(item.productId),
                ),
                Text('${item.quantity}'),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => cartState.increment(item.productId),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => cartState.deleteProduct(item.productId),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
