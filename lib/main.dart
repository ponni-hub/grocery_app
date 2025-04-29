import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grocery_app/api/shared_service.dart';
import 'package:grocery_app/pages/account/acount.dart';
import 'package:grocery_app/pages/dashboard/dashboard_page.dart';
import 'package:grocery_app/pages/login/login_page.dart';
import 'package:grocery_app/pages/products/product_details_page.dart';
import 'package:grocery_app/pages/products/products_page.dart';
import 'package:grocery_app/pages/registration/user_register_page.dart';
import 'package:grocery_app/models/user_model.dart';
import 'package:grocery_app/provider/products_provider.dart';
import 'package:grocery_app/provider/cart_provider.dart'; // ✅ Import your CartProvider
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the database for desktop
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()), // ✅ Added CartProvider here
      ],
      child: FutureBuilder<bool?>(
        future: SharedService.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              builder: EasyLoading.init(),
              home: const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
            );
          } else if (snapshot.hasError) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              builder: EasyLoading.init(),
              home: Scaffold(
                body: Center(child: Text('Error: ${snapshot.error}')),
              ),
            );
          } else {
            final bool isLoggedIn = snapshot.data ?? false;

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              builder: EasyLoading.init(),
              home: const UserRegisterPage(), // Your first page
              routes: {
                '/products': (context) => const ProductsPage(),
                '/product-details': (context) => const ProductDetailsPage(),
                '/account': (context) {
                  final user = ModalRoute.of(context)!.settings.arguments as UserModel;
                  return Acount(user: user);
                },
                '/register': (context) => const UserRegisterPage(),
                '/login': (context) => const LoginPage(),
                '/dashboard': (context) {
                  final user = ModalRoute.of(context)!.settings.arguments as UserModel;
                  return DashboardPage(user: user);
                },
              },
            );
          }
        },
      ),
    );
  }
}
