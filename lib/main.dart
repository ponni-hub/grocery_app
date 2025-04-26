import 'package:flutter/material.dart';
import 'package:grocery_app/pages/products/product_details_page.dart';
import 'package:grocery_app/pages/registration/user_register_page.dart';
import 'package:provider/provider.dart';
import 'package:grocery_app/pages/dashboard/dashboard_page.dart';
import 'package:grocery_app/pages/products/products_page.dart';
import 'package:grocery_app/provider/products_provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Widget defaultHome = UserRegisterPage();

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        initialRoute: '/register',
        routes: {
          '/register': (context) => const UserRegisterPage(),
          '/': (context) => DashboardPage(),
          '/products': (context) => ProductsPage(),
          '/product-details': (context) => ProductDetailsPage(),
        },
      ),
    );
  }
}
