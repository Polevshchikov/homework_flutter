import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:redux/redux.dart';
import 'package:working_calendar/locator_service.dart';
import 'package:working_calendar/redux/app_state.dart';
import 'package:working_calendar/redux/reducers.dart';

import 'pages/start_page.dart';

void main() async {
  sl.registerSingletonAsync<Services>(() async {
    final _services = Services();
    _services.init();
    return _services;
  });
  final store = Store<AppState>(appReducers,
      initialState: AppState(
        rangeStartDate: DateTime.now(),
        rangeEndDate: DateTime.now(),
        isSwitchedOn: false,
        studyingTime: 0,
      ));
  initializeDateFormatting().then((_) => runApp(
        StoreProvider(
          store: store,
          child: MyApp(),
        ),
      ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartPage(),
    );
  }
}
