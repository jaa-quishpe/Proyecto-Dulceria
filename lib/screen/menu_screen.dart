import 'package:dulces/main.dart';
import 'package:dulces/screen/lateral_menu.dart';
import 'package:flutter/material.dart';
import 'package:dulces/theme/app_theme.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, 'carrito'),
            child: const Icon(
              Icons.add_shopping_cart,
              color: Colors.white,
              size: 35.0,
            ),
          ),
        ],
      ),
      drawer: const LateralMenu(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              typeProduct(Colors.white, AppTheme.primary, 'Chocolates'),
              typeProduct(AppTheme.primary, Colors.white, 'Paletas'),
              typeProduct(Colors.white, AppTheme.primary, 'Chicles'),
              typeProduct(AppTheme.primary, Colors.white, 'Moras'),
              typeProduct(Colors.white, AppTheme.primary, 'Botanas'),
            ],
          ),
        ),
      ),
    );
  }

  Widget typeProduct(Color colorText, Color colorBg, String text) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(color: colorText),
        width: MediaQuery.of(context).size.width,
        height: 100.0,
        child: Text(
          text,
          style: TextStyle(
              color: colorBg, fontSize: 64.0, fontWeight: FontWeight.bold),
        ),
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TypeProductos(identification: text)),
      ),
    );
  }
}

class TypeProductos extends StatefulWidget {
  final String identification;
  const TypeProductos({Key? key, required this.identification})
      : super(key: key);

  @override
  State<TypeProductos> createState() => _TypeProductosState();
}

class _TypeProductosState extends State<TypeProductos> {
  late Map<String, dynamic> dataCategory;
  late List<dynamic> data = dataCategory['data'];
  @override
  void initState() {
    super.initState();
    dataCategory = DB.getData(widget.identification.toString());
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.lightBlueAccent;
      }
      return Colors.lightBlueAccent;
    }

    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(dataCategory['name'].toUpperCase()),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => Card(
          elevation: 10,
          child: Column(
            children: [
              ListTile(
                title: Text(data[index]['name']),
                subtitle: Text(data[index]['price']),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () =>
                        MyApp().cart_shopping_list.addAll(dataCategory),
                    child: Text(
                      'agregar'.toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith(getColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        separatorBuilder: (_, __) => const Divider(),
        itemCount: data.length,
      ),
    );
  }
}

class DB {
  static final List<Map<String, dynamic>> data = [
    {
      "name": "paletas",
      "data": [
        {"id": 1, "name": "paletas rico 1", "price": "1.50"},
        {"id": 2, "name": "paletas rico 2", "price": "1.50"},
        {"id": 3, "name": "paletas rico 3", "price": "1.50"},
        {"id": 4, "name": "paletas rico 4", "price": "1.50"},
        {"id": 5, "name": "paletas rico 5", "price": "1.50"},
        {"id": 6, "name": "paletas rico 6", "price": "1.50"},
        {"id": 7, "name": "paletas rico 7", "price": "1.50"},
        {"id": 8, "name": "paletas rico 8", "price": "1.50"},
        {"id": 9, "name": "paletas rico 9", "price": "1.50"},
        {"id": 10, "name": "paletas rico 10", "price": "1.50"},
        {"id": 11, "name": "paletas rico 11", "price": "1.50"},
        {"id": 12, "name": "paletas rico 12", "price": "1.50"},
        {"id": 13, "name": "paletas rico 13", "price": "1.50"},
        {"id": 14, "name": "paletas rico 14", "price": "1.50"},
        {"id": 15, "name": "paletas rico 15", "price": "1.50"},
        {"id": 16, "name": "paletas rico 16", "price": "1.50"},
        {"id": 17, "name": "paletas rico 17", "price": "1.50"},
        {"id": 19, "name": "paletas rico 18", "price": "1.50"},
        {"id": 20, "name": "paletas rico 19", "price": "1.50"},
        {"id": 21, "name": "paletas rico 20", "price": "1.50"},
      ],
    },
    {
      "name": "chocolates",
      "data": [
        {"id": 1, "name": "chocolate kitKat", "price": "1.50"},
        {"id": 2, "name": "chocolate kinder", "price": "1.50"},
        {"id": 3, "name": "chocolate huesitos", "price": "1.50"},
        {"id": 4, "name": "chocolate lacasitos", "price": "1.50"},
        {"id": 5, "name": "chocolate filipinos", "price": "1.50"},
        {"id": 6, "name": "chocolate conguitos", "price": "1.50"},
        {"id": 7, "name": "chocolate M&Ms", "price": "1.50"},
        {"id": 8, "name": "chocolate twix", "price": "1.50"},
        {"id": 9, "name": "chocolate snickers", "price": "1.50"},
        {"id": 10, "name": "chocolate tokke", "price": "1.50"},
        {"id": 11, "name": "chocolate smarties", "price": "1.50"},
        {"id": 12, "name": "chocolate hershey's", "price": "1.50"},
        {"id": 13, "name": "chocolate bounty", "price": "1.50"},
        {"id": 14, "name": "chocolate galak", "price": "1.50"},
        {"id": 15, "name": "chocolate ferrero", "price": "1.50"},
      ],
    },
    {
      "name": "chicles",
      "data": [
        {"id": 1, "name": "chicles rico 1", "price": "1.50"},
        {"id": 2, "name": "chicles rico 2", "price": "1.50"},
        {"id": 3, "name": "chicles rico 3", "price": "1.50"},
        {"id": 4, "name": "chicles rico 4", "price": "1.50"},
        {"id": 5, "name": "chicles rico 5", "price": "1.50"},
        {"id": 6, "name": "chicles rico 6", "price": "1.50"},
        {"id": 7, "name": "chicles rico 7", "price": "1.50"},
        {"id": 8, "name": "chicles rico 8", "price": "1.50"},
        {"id": 9, "name": "chicles rico 9", "price": "1.50"},
        {"id": 10, "name": "chicles rico 10", "price": "1.50"},
        {"id": 11, "name": "chicles rico 11", "price": "1.50"},
        {"id": 12, "name": "chicles rico 12", "price": "1.50"},
        {"id": 13, "name": "chicles rico 13", "price": "1.50"},
        {"id": 14, "name": "chicles rico 14", "price": "1.50"},
        {"id": 15, "name": "chicles rico 15", "price": "1.50"},
        {"id": 16, "name": "chicles rico 16", "price": "1.50"},
        {"id": 17, "name": "chicles rico 17", "price": "1.50"},
        {"id": 19, "name": "chicles rico 18", "price": "1.50"},
        {"id": 20, "name": "chicles rico 19", "price": "1.50"},
        {"id": 21, "name": "chicles rico 20", "price": "1.50"},
      ],
    },
    {
      "name": "moras",
      "data": [
        {"id": 1, "name": "moras rico 1", "price": "1.50"},
        {"id": 2, "name": "moras rico 2", "price": "1.50"},
        {"id": 3, "name": "moras rico 3", "price": "1.50"},
        {"id": 4, "name": "moras rico 4", "price": "1.50"},
        {"id": 5, "name": "moras rico 5", "price": "1.50"},
        {"id": 6, "name": "moras rico 6", "price": "1.50"},
        {"id": 7, "name": "moras rico 7", "price": "1.50"},
        {"id": 8, "name": "moras rico 8", "price": "1.50"},
        {"id": 9, "name": "moras rico 9", "price": "1.50"},
        {"id": 10, "name": "moras rico 10", "price": "1.50"},
        {"id": 11, "name": "moras rico 11", "price": "1.50"},
        {"id": 12, "name": "moras rico 12", "price": "1.50"},
        {"id": 13, "name": "moras rico 13", "price": "1.50"},
        {"id": 14, "name": "moras rico 14", "price": "1.50"},
        {"id": 15, "name": "moras rico 15", "price": "1.50"},
        {"id": 16, "name": "moras rico 16", "price": "1.50"},
        {"id": 17, "name": "moras rico 17", "price": "1.50"},
        {"id": 19, "name": "moras rico 18", "price": "1.50"},
        {"id": 20, "name": "moras rico 19", "price": "1.50"},
        {"id": 21, "name": "moras rico 20", "price": "1.50"},
      ],
    },
    {
      "name": "botanas",
      "data": [
        {"id": 1, "name": "botanas rico 1", "price": "1.50"},
        {"id": 2, "name": "botanas rico 2", "price": "1.50"},
        {"id": 3, "name": "botanas rico 3", "price": "1.50"},
        {"id": 4, "name": "botanas rico 4", "price": "1.50"},
        {"id": 5, "name": "botanas rico 5", "price": "1.50"},
        {"id": 6, "name": "botanas rico 6", "price": "1.50"},
        {"id": 7, "name": "botanas rico 7", "price": "1.50"},
        {"id": 8, "name": "botanas rico 8", "price": "1.50"},
        {"id": 9, "name": "botanas rico 9", "price": "1.50"},
        {"id": 10, "name": "botanas rico 10", "price": "1.50"},
        {"id": 11, "name": "botanas rico 11", "price": "1.50"},
        {"id": 12, "name": "botanas rico 12", "price": "1.50"},
        {"id": 13, "name": "botanas rico 13", "price": "1.50"},
        {"id": 14, "name": "botanas rico 14", "price": "1.50"},
        {"id": 15, "name": "botanas rico 15", "price": "1.50"},
        {"id": 16, "name": "botanas rico 16", "price": "1.50"},
        {"id": 17, "name": "botanas rico 17", "price": "1.50"},
        {"id": 19, "name": "botanas rico 18", "price": "1.50"},
        {"id": 20, "name": "botanas rico 19", "price": "1.50"},
        {"id": 21, "name": "botanas rico 20", "price": "1.50"},
      ],
    },
  ];

  static Map<String, dynamic> getData(String identification) {
    late Map<String, dynamic> dataFinal;
    for (final Map<String, dynamic> item in data) {
      if (item['name'].toString() == identification.toLowerCase()) {
        dataFinal = item;
      }
    }
    return dataFinal;
  }
}
