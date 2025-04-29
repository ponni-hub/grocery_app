// import 'package:flutter/material.dart';
// import '/screens/orders_screen.dart'; // Import the OrdersScreen
// import '/screens/cart_screen/cart_screen.dart'; // Import the CartScreen

// class ProductDetailsScreen extends StatelessWidget {
//   final Map<String, dynamic> product;

//   const ProductDetailsScreen({Key? key, required this.product})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(product['name'] ?? 'Product Details'),
//         backgroundColor: Colors.green,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Product Image
//             if (product['images'] != null && product['images'].isNotEmpty)
//               Image.network(
//                 product['images'][0]['src'] ?? '',
//                 height: 300,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//             const SizedBox(height: 16),

//             // Product Name
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 product['name'] ?? '',
//                 style: const TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),

//             // Product Price
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text(
//                 '\$${product['price'] ?? '0.00'}',
//                 style: const TextStyle(
//                   fontSize: 20,
//                   color: Colors.green,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 16),

//             // Product Description
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 product['description'] ?? 'No description available.',
//                 style: const TextStyle(fontSize: 16),
//               ),
//             ),

//             const SizedBox(height: 16),

//             // Buttons: Add to Cart and Order Now
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   // Add to Cart Button
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Add product to cart
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => CartScreen(product: product),
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         padding: const EdgeInsets.symmetric(vertical: 16.0),
//                       ),
//                       child: const Text(
//                         'Add to Cart',
//                         style: TextStyle(fontSize: 18),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 16),

//                   // Order Now Button
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Navigate to OrdersScreen with product details
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 OrdersScreen(product: product),
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         padding: const EdgeInsets.symmetric(vertical: 16.0),
//                       ),
//                       child: const Text(
//                         'Order Now',
//                         style: TextStyle(fontSize: 18),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
