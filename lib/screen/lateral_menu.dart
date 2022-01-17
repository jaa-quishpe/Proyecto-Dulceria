import 'package:flutter/material.dart';
import 'package:dulces/theme/app_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LateralMenu extends StatefulWidget {
  const LateralMenu({
    Key? key,
  }) : super(key: key);

  @override
  _LateralMenuState createState() => _LateralMenuState();
}

class _LateralMenuState extends State<LateralMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 20.0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            duration: const Duration(
              milliseconds: 50,
            ),
            decoration: const BoxDecoration(
              color: AppTheme.primary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Quiero \nDulces'.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 40.0,
                      fontFamily: 'Impact',
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Categorias'),
                Icon(FontAwesomeIcons.candyCane),
              ],
            ),
            onPressed: () {},
            // icon: FontAwesomeIcons.candyCane,
          ),
          TextButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Método de Pago'),
                Icon(FontAwesomeIcons.wallet),
              ],
            ),
            onPressed: () {},
            // icon: FontAwesomeIcons.wallet,
          ),
          TextButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('A Mis Pedidos'),
                Icon(FontAwesomeIcons.receipt),
              ],
            ),
            onPressed: () {},
            // icon: FontAwesomeIcons.receipt,
          ),
          TextButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Cupones'),
                Icon(FontAwesomeIcons.percentage),
              ],
            ),
            onPressed: () {},
            // icon: FontAwesomeIcons.percentage,
          ),
        ],
      ),
    );
  }
}
