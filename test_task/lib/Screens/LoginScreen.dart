import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_task/Screens/elements/ClipPathClass.dart';
import 'package:test_task/Screens/elements/LoginScreenButton.dart';
import 'package:test_task/Screens/elements/LoginScreenTextForm.dart';
import 'package:test_task/theme/ColorPalette.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  FocusNode focusEmail;
  FocusNode focusPassword;
  //флаг на переход
  bool permissionMove = false;

  @override
  void initState() {
    super.initState();
    focusEmail = FocusNode();
    focusPassword = FocusNode();
  }

  @override
  void dispose() {
    focusEmail.dispose();
    focusPassword.dispose();
    super.dispose();
  }

  ///Метод проверяющий валидацию ввода данных и в случае успеха переходим на страницу
  void _signIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        permissionMove = !permissionMove;
      });
    } else {}
  }

  ///Основное тело страницы
  Widget bodyPage() {
    return Expanded(
      child: FractionallySizedBox(
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: colorWhite,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  LoginScreenTextForm(
                    controller: _controllerEmail,
                    focusNode: focusEmail,
                    nextFocusNode: focusPassword,
                    hintText: 'Email',
                  ),
                  LoginScreenTextForm(
                    controller: _controllerPassword,
                    obscureText: true,
                    focusNode: focusPassword,
                    nextFocusNode: focusPassword,
                    hintText: 'Пароль',
                  ),
                  LoginScreenButton(
                    onPressed: () {
                      _signIn();
                      permissionMove
                          ? Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                builder: (ctx) => Scaffold(),
                              ),
                            )
                          : null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: colorBackground,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              child: ClipPath(
                clipper: ClipPathClass(),
                child:
                    Image.asset("assets/images/bg_login.png", fit: BoxFit.fill),
              ),
            ),
            MediaQuery.of(context).viewInsets.bottom == 0
                ? Positioned(
                    left: 30,
                    right: 30,
                    top: 100,
                    bottom: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Вход',
                          style: TextStyle(
                              color: colorWhite,
                              fontSize: 34.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 40.0),
                        bodyPage(),
                      ],
                    ),
                  )
                : Positioned(
                    left: 30,
                    right: 30,
                    top: 88,
                    bottom: 15,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        bodyPage(),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
