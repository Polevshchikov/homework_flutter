import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/services/auth.dart';
import 'package:firebase_project/utils/validate_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthService _authService = AuthService();
  User user;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    if (user != null) _authService.signOut();
  }

  void singIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      user = await _authService.signInWithEmailAndPassword(
        _controllerEmail.text,
        _controllerPassword.text,
      );

      setState(() {
        _controllerEmail.clear();
        _controllerPassword.clear();
      });
      if (user != null) Navigator.of(context).pushNamed('/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _controllerEmail,
                  validator: (value) {
                    if (value == '') return 'Введите email';
                    if (!validateEmail(value))
                      return 'Поле email заполнено не корректно';
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextFormField(
                  controller: _controllerPassword,
                  validator: (value) {
                    if (value == '') return 'Заполните поле Password';
                    if (value.length < 8)
                      return 'Password должен содержать минимум 8 символов';
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Password'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          ElevatedButton(
            child: Text('Войти'),
            onPressed: () {
              singIn();
            },
          ),
        ],
      ),
    );
  }
}
