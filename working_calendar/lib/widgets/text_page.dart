import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:working_calendar/redux/app_state.dart';

class TextPage extends StatelessWidget {
  const TextPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, vm) => Container(
        child: Text(
            'Дата начала обучения: ${vm.rangeEndDate.day}.${vm.rangeEndDate.month}.${vm.rangeEndDate.year}'),
      ),
    );
  }
}
