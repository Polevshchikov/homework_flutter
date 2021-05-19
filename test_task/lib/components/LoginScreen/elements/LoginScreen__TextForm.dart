import 'package:flutter/material.dart';
import 'package:test_task/components/LoginScreen/elements/ValidateForm.dart';
import 'package:test_task/theme/ColorPalette.dart';

class LoginScreenTextForm extends StatelessWidget {
  const LoginScreenTextForm(
      {Key key,
      this.controller,
      this.obscureText = false,
      this.focusNode,
      this.nextFocusNode,
      this.hintText})
      : super(key: key);

  final TextEditingController controller;
  final bool obscureText;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText:
          obscureText, //TODO: судя по макету точки должны быть больше, я не знаю как увеличить их размер
      focusNode: focusNode,
      style: TextStyle(fontSize: 16, color: colorBlack),
      controller: controller,
      validator: (value) => validateForm(
          value: value, formName: hintText, passwordInput: controller.text),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: TextStyle(fontSize: 16),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: colorBorderActiveForm, width: 1)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: colorBorderNotActiveForm, width: 1)),
      ),
      onFieldSubmitted: (term) {
        focusNode.unfocus();
        if (focusNode != nextFocusNode) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        }
      },
    );
  }
}
