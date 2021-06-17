import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:working_calendar/locator_service.dart';
import 'package:working_calendar/models/date_entity.dart';
import 'package:working_calendar/redux/actions.dart';
import 'package:working_calendar/redux/app_state.dart';
import 'package:working_calendar/utils/constant.dart';

class DropdownMonth extends StatelessWidget {
  const DropdownMonth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of<AppState>(context);
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, vm) => DropdownButton(
          dropdownColor: Color(0xFF2accFa),
          value: listMonths[vm.rangeStartDate.month - 1],
          items: listMonths
              .map(
                (String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ),
              )
              .toList(),
          menuMaxHeight: 200,
          onChanged: (String? newValue) async {
            store.dispatch(RecordDateMonthAction(newDateMonth: newValue!));

            DateEntity dateEntity = await sl
                .get<Services>()
                .dateRepository
                .getloadJsonDate(vm.rangeStartDate.year);

            store.dispatch(GenerateEndDateAction(
              dateEntity: dateEntity,
              isSwitchedOn: vm.isSwitchedOn,
              studyingTime: vm.studyingTime,
              selectedDay: vm.rangeStartDate.day,
              selectedMonth: listMonths[vm.rangeStartDate.month - 1],
              selectedYear: vm.rangeStartDate.year.toString(),
            ));
          }),
    );
  }
}
