import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int opctionView = 0;
  void changeState(int option) => setState(() => opctionView = option);

  @override
  Widget build(BuildContext context) {
    List<Widget> viewsHome = <Widget>[
      LoginScreen(
        changeState: changeState,
      ),
      RegisterScreen(
        changeState: changeState,
      ),
    ];
    return Scaffold(body: Center(child: SizedBox(width: 500.0,child: viewsHome[opctionView])));
  }
}

class LoginScreen extends StatelessWidget {
  final Function changeState;
  const LoginScreen({Key? key, required this.changeState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Quiero \nDulces".toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 55,
                fontWeight: FontWeight.bold,
                fontFamily: 'Impact',
              ),
            ),
            const SizedBox(
              height: 35.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => changeState(1),
                  child: const Text(
                    'Registrate',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Inicia Sesion',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  final Function changeState;
  const RegisterScreen({Key? key, required this.changeState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Quiero \nDulces".toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 55,
                fontWeight: FontWeight.bold,
                fontFamily: 'Impact',
              ),
            ),
            const SizedBox(
              height: 35.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => changeState(0),
                  child: const Text(
                    'Registrate',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Inicia Sesion',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Name',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Age',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
