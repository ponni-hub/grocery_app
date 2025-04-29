import 'package:flutter/material.dart';
import 'package:grocery_app/models/product_item.dart';
import 'package:grocery_app/utils/colors.dart';
import 'package:grocery_app/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class ProductItemCardWidget extends StatelessWidget {
  const ProductItemCardWidget({super.key, required this.item});

  final ProductModel item;
  final double width = 174;
  final double height = 250;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(children: [
          SizedBox(
            height: 75,
            width: MediaQuery.of(context).size.width,
            child: item.images!.isNotEmpty
                ? Image.network(item.images![0].url.toString())
                : const SizedBox(),
          ),
          const SizedBox(height: 10),
          Text(
            item.productName!,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(
                "\$${item.price}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              addWidget(context), // Pass context
            ],
          )
        ]),
      ),
    );
  }

  Widget addWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<CartProvider>(context, listen: false).addToCart(item);

        // Optional: Show a snackbar confirmation
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${item.productName} added to cart')),
        );
      },
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: AppColors.primarycolor,
        ),
        child: const Center(
          child: Icon(Icons.add, color: Colors.white, size: 25),
        ),
      ),
    );
  }
}
