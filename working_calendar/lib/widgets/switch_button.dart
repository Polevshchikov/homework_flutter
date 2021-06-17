import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:working_calendar/redux/actions.dart';
import 'package:working_calendar/redux/app_state.dart';

class SwitchButton extends StatelessWidget {
  const SwitchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of<AppState>(context);
    return Container(
      width: 200,
      child: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, vm) => SwitchListTile(
          title: Align(
              alignment: Alignment.centerRight,
              child: Text(vm.isSwitchedOn ? '4 часа' : '6 часов')),
          value: vm.isSwitchedOn,
          onChanged: (bool value) =>
              store.dispatch(SwitchToggleAction(isSwitchedOn: value)),
        ),
      ),
    );
  }
}
