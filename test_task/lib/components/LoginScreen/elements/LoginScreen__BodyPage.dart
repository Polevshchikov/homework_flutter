import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_task/components/LoginScreen/elements/LoginScreen__Button.dart';
import 'package:test_task/components/LoginScreen/elements/LoginScreen__TextForm.dart';
import 'package:test_task/components/MainScreen/MainScreen.dart';
import 'package:test_task/theme/ColorPalette.dart';

class BodyPage extends StatefulWidget {
  final TextEditingController controllerEmail;
  final FocusNode focusEmail;
  final GlobalKey formKey;
  final TextEditingController controllerPassword;
  final FocusNode focusPassword;
  final bool isBtnEnabled;

  const BodyPage({
    Key key,
    this.controllerEmail,
    this.focusEmail,
    this.formKey,
    this.controllerPassword,
    this.focusPassword,
    this.isBtnEnabled,
  }) : super(key: key);

  @override
  _BodyPageState createState() => _BodyPageState();
}

class _BodyPageState extends State<BodyPage> {
  //флаг, переход на след. экран
  bool _permissionMove = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    formKey = widget.formKey;
  }

//Метод проверяющий валидацию ввода данных и в случае успеха переходим на страницу
  void _signIn() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.reset();
      setState(() {
        _permissionMove = !_permissionMove;
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
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
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  LoginScreenTextForm(
                    controller: widget.controllerEmail,
                    focusNode: widget.focusEmail,
                    nextFocusNode: widget.focusPassword,
                    hintText: 'Email',
                  ),
                  LoginScreenTextForm(
                    controller: widget.controllerPassword,
                    obscureText: true,
                    focusNode: widget.focusPassword,
                    nextFocusNode: widget.focusPassword,
                    hintText: 'Пароль',
                  ),
                  LoginScreenButton(
                    isBtnEnabled: widget.isBtnEnabled,
                    onPressed: () {
                      _signIn();
                      if (_permissionMove) {
                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute<MainScreen>(
                          builder: (BuildContext context) {
                            return MainScreen();
                          },
                        ));
                      }
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
}
