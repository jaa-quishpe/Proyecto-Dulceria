import 'package:dulces/block/login_bloc.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool selectLogin = true;

  @override
  Widget build(BuildContext context) {
    final LoginBloc bloc = LoginBloc();
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffFE0000),
        body: Center(
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
                      onTap: () {
                        setState(() {
                          selectLogin = true;
                        });
                      },
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
                      onTap: () {
                        setState(() {
                          selectLogin = false;
                        });
                      },
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
                (selectLogin) ? _columnSignup(bloc) : _columnLogin(bloc),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textFieldName() {
    return TextFieldGeneral(
      labelText: 'Nombre',
      hintText: 'Eduardo Garcia',
      icon: Icons.person_outline,
      onChanged: (value) {},
    );
  }

  Widget _textFieldEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextFieldGeneral(
          labelText: 'Correo',
          hintText: 'Eduardo Garcia',
          icon: Icons.email_outlined,
          onChanged: bloc.changeEmail,
        );
      },
    );
  }

  Widget _textFieldPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextFieldGeneral(
          labelText: 'Contraseña',
          icon: Icons.lock_outline_rounded,
          obscureText: true,
          onChanged: bloc.changePassword,
        );
      },
    );
  }

  Widget _buttonSignUp() {
    return TextButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(10),
        backgroundColor: MaterialStateProperty.all(
          const Color(0xffFF6969),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: 110,
            vertical: 15.0,
          ),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      child: const Text(
        'Registrarme',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 20.0,
        ),
      ),
      onPressed: () {},
    );
  }

  Widget _columnSignup(LoginBloc bloc) {
    return Column(
      children: [
        const SizedBox(
          height: 25.0,
        ),
        _textFieldName(),
        const SizedBox(
          height: 15.0,
        ),
        _textFieldEmail(bloc),
        const SizedBox(
          height: 15.0,
        ),
        _textFieldPassword(bloc),
        const SizedBox(
          height: 30.0,
        ),
        _buttonSignUp(),
      ],
    );
  }

  Widget _columnLogin(LoginBloc bloc) {
    return Column(
      children: [
        const SizedBox(
          height: 15.0,
        ),
        _textFieldEmailLogin(bloc),
        const SizedBox(
          height: 15.0,
        ),
        _textFieldPasswordLogin(bloc),
        const SizedBox(
          height: 25.0,
        ),
        const Text(
          'Olvidé mi Contraseña',
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 65.0,
        ),
        _buttonLogin(),
      ],
    );
  }

  Widget _textFieldEmailLogin(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextFieldGeneral(
          labelText: 'Correo',
          hintText: 'ejemplo@correo.com',
          icon: Icons.mail_outline,
          onChanged: bloc.changeEmail,
        );
      },
    );
  }

  Widget _textFieldPasswordLogin(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextFieldGeneral(
          labelText: 'Contraseña',
          icon: Icons.lock_outline_rounded,
          obscureText: true,
          onChanged: bloc.changePassword,
        );
      },
    );
  }

  Widget _buttonLogin() {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.resolveWith<double>(
          (states) => 10.0,
        ),
        shape: MaterialStateProperty.resolveWith(
          (states) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) => const Color(0xffFF6969)),
        padding: MaterialStateProperty.resolveWith<EdgeInsets>(
          (states) => const EdgeInsets.symmetric(
            horizontal: 40.0,
          ),
        ),
      ),
      child: Text(
        'Entrar'.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
        ),
      ),
      onPressed: () {
        // setState(() {
        //   Navigator.pushNamed(context, MenuBottomNavigation.id);
        // });
      },
    );
  }
}

class FieldsCustom extends StatelessWidget {
  const FieldsCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TextFieldGeneral extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final Function onChanged;
  final dynamic keyboardType;
  final IconData? icon;
  final bool obscureText;
  final String? errorText;
  const TextFieldGeneral({
    Key? key,
    required this.labelText,
    this.hintText,
    required this.onChanged,
    this.keyboardType,
    this.icon,
    this.obscureText = false,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String change(String value) {
      return value;
    }

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          errorText: errorText,
          prefixIcon: Icon(icon),
          labelText: labelText,
          hintText: hintText,
        ),
        onChanged: (value) => change(value),
      ),
    );
  }
}
