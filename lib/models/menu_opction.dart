import 'package:flutter/cupertino.dart' show IconData, Widget;

class MenuOpction {
  final String route;
  final IconData icon;
  final String name;
  final Widget screen;

  MenuOpction(
      {required this.route,
      required this.icon,
      required this.name,
      required this.screen});
}
