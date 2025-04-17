import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grocery_app/pages/dashboard/dashboard_page.dart';
import 'package:grocery_app/pages/products/products_page.dart';
import 'package:grocery_app/provider/products_provider.dart';

Widget defaultHome = DashboardPage();

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ProductsProvider(),
            child: ProductsPage(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: <String, WidgetBuilder>{
            '/': (context) => defaultHome,
            '/products': (context) =>
                ProductsPage(), // Make sure this is not inside a const MaterialApp
          },
        ));
  }
}
