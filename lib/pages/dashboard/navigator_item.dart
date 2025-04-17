import 'package:flutter/material.dart';
import 'package:grocery_app/pages/account/acount.dart';
import 'package:grocery_app/pages/categories/categories_page.dart';
import 'package:grocery_app/pages/cart/cart.dart';
import 'package:grocery_app/pages/home/home.dart';

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
      index: 0, label: 'Shop', icon: Icons.storefront, screen: Home()),

  NavigatorItem(
      index: 1,
      label: 'Categories',
      icon: Icons.category,
      screen: CategoriesPage()), // 👈 Make sure this is added!

  NavigatorItem(
      index: 2, label: 'Cart', icon: Icons.shopping_cart, screen: Cart()),

  NavigatorItem(
      index: 3, label: 'Account', icon: Icons.person, screen: Account()),
];
