import 'package:flutter/material.dart';
import 'package:test_task/theme/ColorPalette.dart';

class LoginScreenButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isBtnEnabled;
  const LoginScreenButton(
      {Key? key, required this.onPressed, required this.isBtnEnabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: MediaQuery.of(context).size.width * 0.62,
      height: 38.0,
      onPressed: isBtnEnabled ? onPressed : null,
      elevation: 3,
      disabledColor: colorButtonDisable,
      color: colorButtonActiv,
      child: const Text(
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
