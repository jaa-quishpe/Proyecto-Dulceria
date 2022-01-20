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
              typeProduct(AppTheme.primary, Colors.white, 'Galletas'),
              typeProduct(Colors.white, AppTheme.primary, 'Chicles'),
              typeProduct(AppTheme.primary, Colors.white, 'Chupetes'),
              typeProduct(Colors.white, AppTheme.primary, 'Caramelos'),
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
      "name": "chocolates",
      "data": [
        {"id": 1, "name": " KitKat", "price": "1.10"},
        {"id": 2, "name": " Kinder", "price": "2.50"},
        {"id": 3, "name": " Huesitos", "price": "1.15"},
        {"id": 4, "name": " Lacasitos", "price": "1.50"},
        {"id": 5, "name": " Filipinos", "price": "1.75"},
        {"id": 6, "name": " Conguitos", "price": "1.00"},
        {"id": 7, "name": " M&Ms", "price": "2.75"},
        {"id": 8, "name": " Twix", "price": "1.50"},
        {"id": 9, "name": " Snickers", "price": "1.00"},
        {"id": 10, "name": " Tokke", "price": "2.10"},
        {"id": 11, "name": " Smarties", "price": "1.50"},
        {"id": 12, "name": " Hershey's", "price": "2.00"},
        {"id": 13, "name": " Bounty", "price": "1.20"},
        {"id": 14, "name": " Galak", "price": "2.65"},
        {"id": 15, "name": " Ferrero", "price": "3.25"},
      ],
    },
    {
      "name": "galletas",
      "data": [
        {"id": 1, "name": " Oreo", "price": "2.00"},
        {"id": 2, "name": " Amor", "price": "2.25"},
        {"id": 3, "name": " Crackets", "price": "1.00"},
        {"id": 4, "name": " Ricas", "price": "1.75"},
        {"id": 5, "name": " Arthur", "price": "1.30"},
        {"id": 6, "name": " Ducales", "price": "2.05"},
        {"id": 7, "name": " Ritz", "price": "1.95"},
        {"id": 8, "name": " Maria", "price": "2.05"},
        {"id": 9, "name": " Krit", "price": "2.10"},
        {"id": 10, "name": " Club Social", "price": "1.50"},
        {"id": 11, "name": " Festival", "price": "1.95"},
        {"id": 12, "name": " Chiky", "price": "2.10"},
        {"id": 13, "name": " Rellenitas", "price": "1.30"},
        {"id": 14, "name": " Chokis", "price": "2.30"},
        {"id": 15, "name": " Salticas", "price": "2.00"},
        {"id": 16, "name": " Chips Ahoy", "price": "1.20"},
        {"id": 17, "name": " Coco", "price": "2.95"},
        {"id": 19, "name": " Krispiz", "price": "3.00"},
        {"id": 20, "name": "Galak", "price": "2.99"},
        {"id": 21, "name": "Donuts", "price": "2.00"},
      ],
    },
    {
      "name": "chicles",
      "data": [
        {"id": 1, "name": "Orbit", "price": "1.00"},
        {"id": 2, "name": "Bubbaloo", "price": "1.75"},
        {"id": 3, "name": "Canets", "price": "1.10"},
        {"id": 4, "name": "Eclipse", "price": "1.00"},
        {"id": 5, "name": "Bubblicious", "price": "1.20"},
        {"id": 6, "name": "Chiclets", "price": "1.30"},
        {"id": 7, "name": "Trident", "price": "2.20"},
        {"id": 8, "name": "Bang Bang", "price": "1.50"},
        {"id": 9, "name": "Gums", "price": "1.55"},
        {"id": 10, "name": "Clorets", "price": "1.00"},
        {"id": 11, "name": "Poosh", "price": "2.00"},
        {"id": 12, "name": "Xtime", "price": "1.50"},
        {"id": 13, "name": "Agogó", "price": "3.00"},
        {"id": 14, "name": "Boomer", "price": "1.50"},
        {"id": 15, "name": "Halls", "price": "2.95"},
        {"id": 16, "name": "Dubble Bubble", "price": "2.50"},
        {"id": 17, "name": "Exit", "price": "2.00"},
        {"id": 19, "name": "Klets", "price": "1.50"},
        {"id": 20, "name": "Orbit", "price": "1.55"},
        {"id": 21, "name": "Miglobs", "price": "2.00"},
      ],
    },
    {
      "name": "chupetes",
      "data": [
        {"id": 1, "name": "Yoguiño", "price": "1.50"},
        {"id": 2, "name": "BonBonBum", "price": "2.00"},
        {"id": 3, "name": "Popsi", "price": "1.75"},
        {"id": 4, "name": "Pin Pop", "price": "2.30"},
        {"id": 5, "name": "Blow Pop", "price": "2.10"},
        {"id": 6, "name": "Sweet Pops", "price": "1.00"},
        {"id": 7, "name": "Paleriko", "price": "1.50"},
        {"id": 8, "name": "Rockaleta", "price": "1.20"},
        {"id": 9, "name": "Globo Pop", "price": "1.95"},
        {"id": 10, "name": "Chupa Chups", "price": "2.00"},
        {"id": 11, "name": "Chupi Plum", "price": "1.65"},
        {"id": 12, "name": "Cherry Stick", "price": "2.00"},
        {"id": 13, "name": "Plop", "price": "3.00"},
        {"id": 14, "name": "Candy Mix", "price": "1.95"},
      ],
    },
    {
      "name": "caramelos",
      "data": [
        {"id": 1, "name": "Fisherman", "price": "1.50"},
        {"id": 2, "name": "Mentos", "price": "2.00"},
        {"id": 3, "name": "Gummy", "price": "1.75"},
        {"id": 4, "name": "Smint", "price": "1.95"},
        {"id": 5, "name": "Sugus", "price": "2.00"},
        {"id": 6, "name": "Palotes", "price": "1.25"},
        {"id": 7, "name": "Mentolin", "price": "2.00"},
        {"id": 8, "name": "Wether's", "price": "2.00"},
        {"id": 9, "name": "Lonka", "price": "1.50"},
        {"id": 10, "name": "Gerio", "price": "1.75"},
        {"id": 11, "name": "Kopiko", "price": "3.00"},
        {"id": 12, "name": "Popsi Pum", "price": "1.85"},
        {"id": 13, "name": "Misky", "price": "2.00"},
        {"id": 14, "name": "Butter Toffees", "price": "1.25"},
        {"id": 15, "name": "Leche y Miel", "price": "1.50"},
        {"id": 16, "name": "Creme Savers", "price": "2.00"},
        {"id": 17, "name": "Strong", "price": "1.50"},
        {"id": 19, "name": "Flynn Paff", "price": "1.30"},
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
