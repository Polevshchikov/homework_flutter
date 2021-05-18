import 'package:flutter/material.dart';
import 'package:test_task/theme/ColorPalette.dart';

class LoginScreenTextForm extends StatefulWidget {
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
  _LoginScreenTextFormState createState() => _LoginScreenTextFormState();
}

class _LoginScreenTextFormState extends State<LoginScreenTextForm> {
  ///Валидация форм
  dynamic validateForm(
      {String value, String formName, String passwordInput = ''}) {
    if (value == '') {
      return 'Заполните поле ' + formName;
    }
    if (formName == 'Email') {
      if (!validateEmail(value)) {
        return 'Поле ' + formName + ' заполнено не \nкорректно';
      }
    }
    if (formName == 'Пароль') {
      if (value.length < 6) {
        return 'Password должен содержать \nминимум 6 символов';
      }
    }
    return null;
  }

  ///Метод валидации Email
  bool validateEmail(String value) {
    var pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    var regex = RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText,
      focusNode: widget.focusNode,
      style: TextStyle(fontSize: 16, color: colorBlack),
      controller: widget.controller,
      validator: (value) => validateForm(
          value: value,
          formName: widget.hintText,
          passwordInput: widget.controller.text),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: widget.hintText,
        labelStyle: TextStyle(fontSize: 16, color: colorTextActiveForm),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: colorBorderActiveForm, width: 1)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: colorBorderNotActiveForm, width: 1)),
      ),
      onFieldSubmitted: (term) {
        widget.focusNode.unfocus();
        if (widget.focusNode != widget.nextFocusNode) {
          FocusScope.of(context).requestFocus(widget.nextFocusNode);
        }
      },
    );
  }
}
