import 'package:dulces/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CarritoScreen extends StatefulWidget {
  final Map<String, dynamic> Function(Map<String, dynamic>)? addProduct;
  final Function? showAllProduct;
  final Function(int)? deleteProduct;
  final Function? deleteProducts;
  const CarritoScreen(
      {Key? key,
      this.addProduct,
      this.showAllProduct,
      this.deleteProduct,
      this.deleteProducts})
      : super(key: key);

  @override
  State<CarritoScreen> createState() => _CarritoScreenState();
}

class _CarritoScreenState extends State<CarritoScreen> {
  Map<String, dynamic> cart_shopping_list = {};
  Map<String, dynamic> get_cart_shopping_list() => cart_shopping_list;
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
