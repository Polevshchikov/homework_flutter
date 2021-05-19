import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_task/components/LoginScreen/elements/LoginScreen_BodyPage.dart';
import 'package:test_task/components/LoginScreen/elements/ClipPathClass.dart';

import 'package:test_task/theme/ColorPalette.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  late FocusNode _focusEmail;
  late FocusNode _focusPassword;
  //Флаг, активная кнопка
  bool _isBtnEnabled = false;

  @override
  void initState() {
    super.initState();
    _focusEmail = FocusNode();
    _focusPassword = FocusNode();
    _controllerPassword.addListener(() {
      setState(() {
        _isBtnEnabled = _controllerPassword.value.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _focusEmail.dispose();
    _focusPassword.dispose();
    _controllerPassword.dispose();
    super.dispose();
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
                child: Image.asset(
                  "assets/images/bg_login.png",
                  fit: BoxFit.fill,
                ),
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
                        const Text(
                          'Вход',
                          style: TextStyle(
                              color: colorWhite,
                              fontSize: 34.0,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 40.0),
                        BodyPage(
                          controllerEmail: _controllerEmail,
                          focusEmail: _focusEmail,
                          formKey: _formKey,
                          controllerPassword: _controllerPassword,
                          focusPassword: _focusPassword,
                          isBtnEnabled: _isBtnEnabled,
                        ),
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
                        BodyPage(
                          controllerEmail: _controllerEmail,
                          focusEmail: _focusEmail,
                          formKey: _formKey,
                          controllerPassword: _controllerPassword,
                          focusPassword: _focusPassword,
                          isBtnEnabled: _isBtnEnabled,
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
