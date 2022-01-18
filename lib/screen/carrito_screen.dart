import 'package:dulces/main.dart';
import 'package:dulces/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CartShoppingList {
  static Map<String, dynamic> cart_shopping_list = {};
}

class CarritoScreen extends StatefulWidget {
  const CarritoScreen({Key? key}) : super(key: key);

  @override
  State<CarritoScreen> createState() => _CarritoScreenState();
}

class _CarritoScreenState extends State<CarritoScreen> {
  void getCartShoppingList() {}
  Map<String, dynamic> cart_shopping_list = MyApp().getCartShoppingList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text('Carrito'.toUpperCase()),
      ),
      body: cart_shopping_list.isNotEmpty
          ? ListView.separated(
              itemBuilder: (context, index) => Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: ListTile(
                  title: Text(cart_shopping_list['name']),
                  subtitle: Text(cart_shopping_list['data'][index]['name']),
                  trailing: Text(cart_shopping_list['data'][index]['price']),
                ),
              ),
              itemCount: cart_shopping_list.length,
              separatorBuilder: (_, __) => const Divider(),
            )
          : Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0)),
                child: const Text(
                  'Aún no tienes productos en el carrito',
                  style: TextStyle(color: AppTheme.primary),
                ),
              ),
            ),
    );
  }
}
