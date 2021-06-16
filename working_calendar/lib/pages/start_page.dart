import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:working_calendar/locator_service.dart';
import 'package:working_calendar/models/date_entity.dart';
import 'package:working_calendar/redux/actions.dart';
import 'package:working_calendar/redux/app_state.dart';
import 'package:working_calendar/utils/constant.dart';
import 'package:working_calendar/widgets/calendar_start_page.dart';
import 'package:working_calendar/widgets/dropdown_month.dart';
import 'package:working_calendar/widgets/dropdown_year.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: StoreConnector<AppState, AppState>(
            converter: (store) => store.state,
            builder: (context, vm) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Colors.green,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 40,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '${vm.rangeStartDate.day}',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  child: Icon(Icons.arrow_drop_up),
                                  onTap: () => store.dispatch(AddDayAction()),
                                ),
                                GestureDetector(
                                  child: Icon(Icons.arrow_drop_down),
                                  onTap: () =>
                                      store.dispatch(RemoveDayAction()),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: DropdownMonth(),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: DropdownYear(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 300,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                    ],
                    onChanged: (value) {
                      if (value != '') {
                        int inputTime = int.parse(value);
                        store.dispatch(
                            InputStudyingTimeAction(studyingTime: inputTime));
                      } else {
                        store
                            .dispatch(InputStudyingTimeAction(studyingTime: 0));
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Введите количество часов курса',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      child: TextButton(
                          onPressed: () async {
                            DateEntity dateEntity = await sl
                                .get<Services>()
                                .dateRepository
                                .getloadJsonDate(vm.rangeStartDate.year);

                            store.dispatch(GenerateEndDateAction(
                              dateEntity: dateEntity,
                              isSwitchedOn: vm.isSwitchedOn,
                              studyingTime: vm.studyingTime,
                              selectedDay: vm.rangeStartDate.day,
                              selectedMonth:
                                  listMonths[vm.rangeStartDate.month - 1],
                              selectedYear: vm.rangeStartDate.year.toString(),
                            ));
                          },
                          child: Text('click')),
                    ),
                    Container(
                      width: 200,
                      child: SwitchListTile(
                        title: Align(
                            alignment: Alignment.centerRight,
                            child:
                                Text(vm.isSwitchedOn ? '4 часа' : '6 часов')),
                        value: vm.isSwitchedOn,
                        onChanged: (bool value) => store
                            .dispatch(SwitchToggleAction(isSwitchedOn: value)),
                      ),
                    ),
                  ],
                ),
                CalendarStartPage(),
                const SizedBox(height: 20),
                Text(
                    'Дата начала обучения: ${vm.rangeEndDate.day}.${vm.rangeEndDate.month}.${vm.rangeEndDate.year}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
