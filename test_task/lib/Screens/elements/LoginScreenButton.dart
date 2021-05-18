import 'package:flutter/material.dart';
import 'package:test_task/theme/ColorPalette.dart';

class LoginScreenButton extends StatelessWidget {
  final VoidCallback onPressed;
  const LoginScreenButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 230.0,
      height: 38.0,
      onPressed: onPressed,
      elevation: 3,
      color: colorButton,
      child: Text(
        'Войти',
        style: TextStyle(
          color: colorWhite,
          fontSize: 16.0,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}
