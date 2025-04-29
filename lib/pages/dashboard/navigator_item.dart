import 'package:flutter/material.dart';
import 'package:grocery_app/pages/account/acount.dart';
import 'package:grocery_app/pages/categories/categories_page.dart';
import 'package:grocery_app/pages/cart/cart.dart';
import 'package:grocery_app/pages/home/home.dart';
import 'package:grocery_app/models/user_model.dart';

// NavigatorItem class
class NavigatorItem {
  final int index;
  final String label;
  final IconData icon;
  final Widget screen;

  NavigatorItem({
    required this.index,
    required this.label,
    required this.icon,
    required this.screen,
  });
}

List<NavigatorItem> navigatoritems = [
  NavigatorItem(
      index: 0, label: 'Shop', icon: Icons.storefront, screen: HomeScreen()),

  NavigatorItem(
      index: 1,
      label: 'Categories',
      icon: Icons.category,
      screen: CategoriesPage()),

  NavigatorItem(
      index: 2, label: 'Cart', icon: Icons.shopping_cart, screen: CartPage()),

  // Temporarily set the Account screen without userModel
  // NavigatorItem(
  //   index: 3,
  //   label: 'Account',
  //   icon: Icons.person,
  //   screen: Placeholder(), // Placeholder until userModel is passed
  // ),
];

// Example on how to push Account page with userModel
// Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) => Acount(user: userModel), // Pass userModel here
//   ),
// );
