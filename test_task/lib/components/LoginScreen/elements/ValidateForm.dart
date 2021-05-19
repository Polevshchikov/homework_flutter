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
