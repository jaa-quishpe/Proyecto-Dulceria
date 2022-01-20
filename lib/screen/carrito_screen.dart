import 'package:dulces/theme/app_theme.dart';
import 'package:flutter/material.dart';

// CARRITO DE COMPRAS
class Carrito {
  static late List<Map<String, dynamic>> listProducts = [];
  static void addProduct(Map<String, dynamic> product) =>
      listProducts.add(product);
  static void deleteProduct(int index) => listProducts.removeAt(index);
}

class CarritoScreen extends StatefulWidget {
  final Function? getListProducts;
  const CarritoScreen({
    Key? key,
    this.getListProducts,
  }) : super(key: key);

  @override
  State<CarritoScreen> createState() => _CarritoScreenState();
}

class _CarritoScreenState extends State<CarritoScreen> {
  late List<Map<String, dynamic>> listProducts = [];
  late double valorPagar = 0;

  double calcularValorPagar() {
    if (listProducts.isNotEmpty) {
      for (final Map<String, dynamic> item in listProducts) {
        valorPagar += double.parse(item['price']);
      }
      return valorPagar;
    } else {
      return 0;
    }
  }

  @override
  void initState() {
    super.initState();
    listProducts = Carrito.listProducts;
    valorPagar = calcularValorPagar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text('Carrito'.toUpperCase()),
      ),
      body: Column(
        children: [
          Expanded(
            child: listProducts.isNotEmpty
                ? ListView.separated(
                    itemBuilder: (context, index) => Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      child: ListTile(
                        title: Text(listProducts[index]['name']),
                        subtitle: Text(listProducts[index]['price']),
                        trailing: GestureDetector(
                          onTap: () => setState(() {
                            Carrito.deleteProduct(index);
                            calcularValorPagar();
                          }),
                          child: const Icon(Icons.production_quantity_limits),
                        ),
                      ),
                    ),
                    itemCount: listProducts.length,
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
          ),
          Container(
            width: double.infinity,
            height: 50.0,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Text(
                  'Valor a pagar: $valorPagar',
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
