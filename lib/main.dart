import 'package:flutter/material.dart';
import 'package:dulces/theme/app_theme.dart';
import 'package:dulces/routes/app_routes.dart';
import 'package:dulces/screen/screens.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  Map<String, dynamic> cart_shopping_list =
      CartShoppingList.cart_shopping_list;
  Map<String, dynamic> getCartShoppingList() {
    return cart_shopping_list;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: const HomeScreen(),
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.getAppRoutes(),
      theme: AppTheme.lightTheme,
    );
  }
}
