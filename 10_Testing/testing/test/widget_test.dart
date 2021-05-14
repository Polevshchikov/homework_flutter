// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:testing/views/login_view.dart';

void main() {
  group('Login view tests', () {
    testWidgets("test description", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: LoginView(),
        localizationsDelegates: [
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
      ));

      expect(find.text('Вход'), findsOneWidget);
      expect(find.byKey(Key('fieldEmail')), findsOneWidget);
      expect(find.byKey(Key('fieldPhone')), findsOneWidget);
      expect(find.byKey(Key('fieldButton')), findsOneWidget);
      expect(find.text('Отправить'), findsOneWidget);
      expect(find.text('Еще нет аккаунта? '), findsOneWidget);
      expect(find.text('Добро пожаловать'), findsNothing);

      await tester.enterText(find.byKey(Key('fieldEmail')), 'test@test.ru');
      expect(find.text('test@test.ru'), findsOneWidget);

      await tester.enterText(find.byKey(Key('fieldPhone')), '88001001010');
      expect(find.text('88001001010'), findsOneWidget);

      await tester.tap(find.text('Отправить'));
      await tester.pump();
      expect(find.text('Добро пожаловать'), findsOneWidget);
    });
  });

  group('Register view tests', () {
    testWidgets("test description", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: LoginView(),
        localizationsDelegates: [
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
      ));

      await tester.tap(find.byKey(Key('fieldButton')));
      await tester.pump();
      expect(find.text('Регистрация'), findsOneWidget);
      expect(find.byKey(Key('fieldFirstName')), findsOneWidget);
      expect(find.byKey(Key('fieldLastName')), findsOneWidget);
      expect(find.byKey(Key('fieldEmail')), findsOneWidget);
      expect(find.byKey(Key('fieldPhone')), findsOneWidget);
      expect(find.byKey(Key('fieldButton')), findsOneWidget);
      expect(find.text('Отправить'), findsOneWidget);
      expect(find.text('Уже есть аккаунт?'), findsOneWidget);

      await tester.enterText(find.byKey(Key('fieldFirstName')), 'Tester');
      expect(find.text('Tester'), findsOneWidget);

      await tester.enterText(find.byKey(Key('fieldLastName')), 'Test');
      expect(find.text('Test'), findsOneWidget);

      await tester.enterText(find.byKey(Key('fieldEmail')), 'test@test.ru');
      expect(find.text('test@test.ru'), findsOneWidget);

      await tester.enterText(find.byKey(Key('fieldPhone')), '88001001010');
      expect(find.text('88001001010'), findsOneWidget);

      await tester.tap(find.text('Отправить'));
      await tester.pump();
      expect(find.text('Вы успешно зарегистрировались'), findsOneWidget);
    });
  });
}
