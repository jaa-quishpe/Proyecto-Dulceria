import 'package:flutter/material.dart';

class CarritoScreen extends StatelessWidget {
  const CarritoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text('Carrito'.toUpperCase()),
      ),
      body: const Text("Estás en el carrito de compras !"),
    );
  }
}
