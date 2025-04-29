import 'package:flutter/material.dart';
import 'package:grocery_app/pages/account/acount.dart';
import 'package:grocery_app/pages/categories/categories_page.dart';
import 'package:grocery_app/pages/cart/cart.dart';
import 'package:grocery_app/pages/home/home.dart';
import 'package:grocery_app/models/user_model.dart';

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
  // The Account screen is no longer in the static navigatoritems list
];

class DashboardPage extends StatefulWidget {
  final UserModel user;

  const DashboardPage({Key? key, required this.user}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigatoritems[currentIndex].screen,
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });

        // Handle navigation for the Account tab
        if (index == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  Acount(user: widget.user), // Pass userModel here
            ),
          );
        }
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepOrange, // AppColors.primarycolor, etc.
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      unselectedItemColor: Colors.black,
      items: navigatoritems
          .map((e) => BottomNavigationBarItem(
                label: e.label,
                icon: Icon(e.icon),
              ))
          .toList()
        ..add(
          BottomNavigationBarItem(
            label: 'Account',
            icon: Icon(Icons.person),
          ),
        ),
    );
  }
}
