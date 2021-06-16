import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:working_calendar/redux/app_state.dart';
import 'package:working_calendar/utils/utils.dart';

class CalendarStartPage extends StatelessWidget {
  const CalendarStartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of<AppState>(context);
    return Card(
      elevation: 5,
      child: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, vm) => TableCalendar(
          startingDayOfWeek: StartingDayOfWeek.monday,
          locale: 'ru_RU',
          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: vm.rangeEndDate,
          selectedDayPredicate: (day) => isSameDay(
              vm.rangeStartDate, day), //TODO: возможно внести еще селекторДей
          rangeStartDay: vm.rangeEndDate,
          rangeEndDay: vm.rangeStartDate,
          onDaySelected: (selectedDay, focusedDay) {
            // setState(() {
            //   _selectedDay = selectedDay;
            //   _focusedDay = focusedDay;
            //   _rangeStart =
            //       _selectedDay.subtract(Duration(days: calcDay.ceil()));
            //   _rangeEnd = _selectedDay;
            // });
          },
          // onRangeSelected: (start, end, focusedDay) {
          //   setState(() {
          //     _selectedDay = null;
          //     _focusedDay = focusedDay;
          //     _rangeStart = start;
          //     _rangeEnd = end;
          //     _rangeSelectionMode = RangeSelectionMode.toggledOn;
          //   });
          // },
          // onPageChanged: (focusedDay) {
          //   _focusedDay = focusedDay;
          // },
        ),
      ),
    );
  }
}
