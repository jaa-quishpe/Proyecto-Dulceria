import 'package:flutter/material.dart';
import 'package:dulces/models/menu_opction.dart';
import 'package:dulces/screen/screens.dart';

class AppRoutes {
  static const initialRoute = 'home';
  static final menuOptions = <MenuOpction>[
    MenuOpction(
        route: 'home',
        name: 'Home Screen',
        screen: const HomeScreen(),
        icon: Icons.home_max_sharp),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    for (final option in menuOptions) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }
    return appRoutes;
  }

  // static Route<dynamic> onGenerateRoute(RouteSettings settings) {
  //   return MaterialPageRoute(builder: (context) => const AlertScreen());
  // }
}
