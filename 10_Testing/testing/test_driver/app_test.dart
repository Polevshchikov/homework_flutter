// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Transition form tests', () {
    FlutterDriver driver;

    final filedFinderButton = find.byValueKey('fieldButton');

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // tearDownAll(() async {
    //   if (driver != null) {
    //     driver.close();
    //   }
    // });
    test('Question text', () async {
      final success = find.text('Еще нет аккаунта? ');
      expect(await driver.getText(success), 'Еще нет аккаунта? ');
    });

    test('Test tap TextButton', () async {
      await driver.tap(filedFinderButton);
    });
    test('Question text', () async {
      final success = find.text('Уже есть аккаунт?');
      expect(await driver.getText(success), 'Уже есть аккаунт?');
    });

    test('Test tap TextButton', () async {
      await driver.tap(filedFinderButton);
    });
  });
  group('Login form tests', () {
    FlutterDriver driver;

    final filedFinderEmail = find.byValueKey('fieldEmail');
    final filedFinderPhone = find.byValueKey('fieldPhone');
    final filedFinderSubmit = find.text('Отправить');

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // tearDownAll(() async {
    //   if (driver != null) {
    //     driver.close();
    //   }
    // });
    test('Test email field', () async {
      await driver.tap(filedFinderEmail);
      await driver.waitFor(find.text(''));
      await driver.enterText('test@test.ru');
      await driver.waitFor(find.text('test@test.ru'));
    });

    test('Test phone field', () async {
      await driver.tap(filedFinderPhone);
      await driver.waitFor(find.text(''));
      await driver.enterText('88001001010');
      await driver.waitFor(find.text('88001001010'));
    });

    test('Test tap submit', () async {
      await driver.tap(filedFinderSubmit);
    });

    test('Success text', () async {
      final success = find.text('Добро пожаловать');
      expect(await driver.getText(success), 'Добро пожаловать');
    });
  });

  group('Rigister form tests', () {
    FlutterDriver driver;

    final filedFinderFirstName = find.byValueKey('fieldFirstName');
    final filedFinderLastName = find.byValueKey('fieldLastName');
    final filedFinderEmail = find.byValueKey('fieldEmail');
    final filedFinderPhone = find.byValueKey('fieldPhone');
    final filedFinderButton = find.byValueKey('fieldButton');
    final filedFinderSubmit = find.text('Отправить');

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    test('Test tap TextButton', () async {
      await driver.tap(filedFinderButton);
    });
    test('Test FirstName field', () async {
      await driver.tap(filedFinderFirstName);
      await driver.waitFor(find.text(''));
      await driver.enterText('Tester');
      await driver.waitFor(find.text('Tester'));
    });
    test('Test LastName field', () async {
      await driver.tap(filedFinderLastName);
      await driver.waitFor(find.text(''));
      await driver.enterText('Test');
      await driver.waitFor(find.text('Test'));
    });

    test('Test phone field', () async {
      await driver.tap(filedFinderPhone);
      await driver.waitFor(find.text(''));
      await driver.enterText('88001001010');
      await driver.waitFor(find.text('88001001010'));
    });
    test('Test email field', () async {
      await driver.tap(filedFinderEmail);
      await driver.waitFor(find.text(''));
      await driver.enterText('test@test.ru');
      await driver.waitFor(find.text('test@test.ru'));
    });

    test('Test tap submit', () async {
      await driver.tap(filedFinderSubmit);
    });

    test('Success text', () async {
      final success = find.text('Вы успешно зарегистрировались');
      expect(await driver.getText(success), 'Вы успешно зарегистрировались');
    });
  });
}
