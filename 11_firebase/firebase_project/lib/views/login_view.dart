import 'package:firebase_project/components/login_form.dart';
import 'package:firebase_project/components/register_form.dart';
import 'package:firebase_project/utils/wave_clipper.dart';
import 'package:flutter/material.dart';

enum FormType { login, register }

class LoginView extends StatefulWidget {
  static const routName = '/';
  LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  FormType _formType = FormType.login;

  _switchForm() {
    setState(() {
      _formType =
          _formType == FormType.login ? FormType.register : FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _logo(String logo) {
      return Padding(
        padding: EdgeInsets.only(top: 50),
        child: Container(
          child: Align(
            child: Text(
              logo,
              style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
      );
    }

    Widget _bottomWave() {
      return Expanded(
        child: Align(
          child: ClipPath(
            child: Container(
              color: Colors.blue,
              height: 200,
            ),
            clipper: BottomWaveClipper(),
          ),
          alignment: Alignment.bottomCenter,
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text('ToDo app'),
        ),
      ),
      body: Column(
        children: <Widget>[
          _formType == FormType.login ? _logo('Вход') : _logo('Регистрация'),
          SizedBox(
            height: 50,
          ),
          _formType == FormType.login ? LoginForm() : RegisterForm(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _formType != FormType.login
                    ? 'Уже есть аккаунт?'
                    : 'Еще нет аккаунта? ',
              ),
              TextButton(
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text:
                          _formType != FormType.login ? 'Войти' : 'Регистрация',
                    )
                  ], style: Theme.of(context).textTheme.bodyText1),
                ),
                onPressed: _switchForm,
              ),
            ],
          ),
          _bottomWave(),
        ],
      ),
    );
  }
}
