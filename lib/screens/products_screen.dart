import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/cart_state.dart';
import '../state/products_state.dart';
import 'cart_screen.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productState = context.watch<ProductsState>();
    final products = productState.products;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: const [
          CartButton(),
          SizedBox(width: 10),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return ListTile(
            onTap: () => context.read<CartState>().addProduct(product),
            leading: Hero(
              tag: product.id,
              child: Image.network(product.image),
            ),
            title: Text(product.title),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}

class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCount = context.watch<CartState>().items.length;

    return Badge.count(
      count: cartCount,
      child: IconButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CartScreen())),
        icon: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
