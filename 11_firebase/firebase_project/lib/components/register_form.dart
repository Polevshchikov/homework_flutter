import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/services/auth.dart';
import 'package:firebase_project/utils/validate_email.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthService _authService = AuthService();
  User user;
  bool _obscureText = true;
  String _password;

  bool _isSuccess = false;
  @override
  void initState() {
    super.initState();
    inputData();
  }

  void _handleSubmit() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isSuccess = true;
      });
      _formKey.currentState.save();
      user = await _authService.signUp(
        _controllerEmail.text,
        _controllerPassword.text,
      );
      User updateUser =
          await _authService.updateUser(displayName: _controllerName.text);

      if (user != null) {
        Navigator.of(context).pushNamed('/profile');
      }
      _formKey.currentState.reset();
    }
  }

  void inputData() {
    User user = auth.currentUser;

    if (user != null) {
      final uid = user.uid;
      print(uid);
      print(user.email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: _controllerName,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == '') return 'Заполните поле name';
                return null;
              },
            ),
            TextFormField(
              controller: _controllerEmail,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == '') return 'Заполните поле email';
                if (!validateEmail(value)) return 'Емейл не корректный';
                return null;
              },
            ),
            TextFormField(
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              validator: (value) {
                if (value == '') return 'Заполните поле Password';
                if (value.length < 8)
                  return 'Password должен содержать минимум 8 символов';
                return null;
              },
              onChanged: (String value) {
                setState(() {
                  this._password = value;
                });
              },
            ),
            TextFormField(
              enabled: this._password != null && this._password.isNotEmpty,
              obscureText: _obscureText,
              controller: _controllerPassword,
              decoration: InputDecoration(
                labelText: 'Re-type password',
              ),
              validator: (value) {
                if (value == '') return 'Заполните поле Password';
                if (value.length < 8)
                  return 'Password должен содержать минимум 8 символов';
                if (_password != _controllerPassword.text)
                  return 'Значения в полях Password не совпадают';
                return null;
              },
            ),
            SizedBox(
              height: 50.0,
            ),
            ElevatedButton(
              child: Text('Регистрация'),
              onPressed: () {
                _handleSubmit();
              },
            ),
            if (_isSuccess) Text('Вы успешно зарегистрировались'),
          ],
        ),
      ),
    );
  }
}
