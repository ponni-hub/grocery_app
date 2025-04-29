import 'package:flutter/material.dart';
import 'package:grocery_app/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: cartProvider.cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                final product = cartProvider.cartItems[index];
                return ListTile(
                  leading: product.images!.isNotEmpty
                      ? Image.network(product.images![0].url.toString(), width: 50, height: 50)
                      : null,
                  title: Text(product.productName ?? ''),
                  subtitle: Text('\$${product.price}'),
                );
              },
            ),
    );
  }
}
