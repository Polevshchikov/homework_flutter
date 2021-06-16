import 'package:redux/redux.dart';
import 'package:working_calendar/models/date_entity.dart';
import 'package:working_calendar/redux/actions.dart';
import 'package:working_calendar/redux/app_state.dart';
import 'package:working_calendar/utils/constant.dart';

import '../locator_service.dart';

AppState appReducers(AppState state, dynamic action) => AppState(
      rangeEndDate: _generateDateReducer(state.rangeEndDate, action),
      rangeStartDate: _generateStartDateReducer(state.rangeStartDate, action),
      isSwitchedOn: _switchedReducer(state.isSwitchedOn, action),
      studyingTime: _studyingTimeReducer(state.studyingTime, action),
    );

//=================

/// Ввод часов обучения
Reducer<int> _studyingTimeReducer = combineReducers([
  TypedReducer<int, InputStudyingTimeAction>(_setStudyingTimeReducer),
]);
int _setStudyingTimeReducer(int studyingTime, InputStudyingTimeAction action) =>
    studyingTime = action.studyingTime;

//=================

/// Переключения ползунка 4/6 часов
Reducer<bool> _switchedReducer = combineReducers([
  TypedReducer<bool, SwitchToggleAction>(_switchedOnOffReducer),
]);

bool _switchedOnOffReducer(bool switchedValue, SwitchToggleAction action) =>
    switchedValue = action.isSwitchedOn;

//=================

/// Генерация начальной даты
Reducer<DateTime> _generateDateReducer = combineReducers([
  TypedReducer<DateTime, GenerateEndDateAction>(_endDateReducer),
]);

DateTime _endDateReducer(DateTime date, GenerateEndDateAction action) {
  DateEntity dateYear = action.dateEntity;

  /// Метод загрузки Json данных выходных и праздников
  Future<DateEntity> _loadDate({int? year}) async => await sl
      .get<Services>()
      .dateRepository
      .getloadJsonDate(year!)
      .then((date) => date);

  /// Метод получения даты в типе DateTime из String
  DateTime _getItemListMonth() {
    for (var item = 0; item < listMonths.length; item++) {
      if (listMonths[item] == action.selectedMonth) {
        if (item < 10) {
          return DateTime.parse(
              '${action.selectedYear}-0${++item}-${action.selectedDay}');
        }
        return DateTime.parse(
            '${action.selectedYear}-${++item}-${action.selectedDay}');
      }
    }
    return DateTime.now();
  }

  /// Метод сравнения даты с календарем выходных и праздников
  bool _overlapDate(List<int> jsonDay, int preliminaryDay) {
    // print(jsonDay.where((day) => day == preliminaryDay));
    if (jsonDay.where((day) => day == preliminaryDay).isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  double calcDay = 0;

  /// Расчетные, рабочие дени состоит из 4х или 6ти часов
  action.isSwitchedOn
      ? calcDay = (action.studyingTime / 4)
      : calcDay = (action.studyingTime / 6);

  int _calcDayCeil = calcDay.ceil();
  DateTime preliminaryDate = _getItemListMonth();
  int yearJson = int.parse(action.selectedYear);
  int monthJson = preliminaryDate.month;
  DateTime newDate = DateTime.now();

  /// Логика сравнения и добавление праздничных и выходных дней к расчетам
  for (int i = 0; i < _calcDayCeil; i++) {
    DateTime inputDate = preliminaryDate.subtract(Duration(days: (i)));
    int preliminaryDay = inputDate.day;
    if (yearJson == inputDate.year) {
      if (monthJson == inputDate.month) {
        List<int> jsonDayList = dateYear.months[monthJson - 1].days;
        if (_overlapDate(jsonDayList, preliminaryDay)) {
          _calcDayCeil++;
        }
      } else {
        monthJson = inputDate.month;
        i--;
      }
    } else {
      yearJson = inputDate.year;
      _loadDate(year: yearJson).then((value) {
        return dateYear = value;
      });
      i--;
    }
    newDate = inputDate;
  }

  return newDate;
}

//=================

/// Генерация конечной даты
Reducer<DateTime> _generateStartDateReducer = combineReducers([
  TypedReducer<DateTime, AddDayAction>(_addDayReducer),
  TypedReducer<DateTime, RemoveDayAction>(_removeDayReducer),
  TypedReducer<DateTime, ResetDayAction>(_resetDayReducer),
  TypedReducer<DateTime, RecordDateMonthAction>(_setRecordMonthReducer),
  TypedReducer<DateTime, RecordDateYearAction>(_setRecordYearReducer),
]);

DateTime _addDayReducer(DateTime date, AddDayAction action) {
  return date.add(const Duration(days: 1));
  // int selectedIntYear = int.parse(action.selectedYear);
  // int selectedIntMonth = 1;
  // for (var item = 0; item < listMonths.length; item++) {
  //   if ('${listMonths[item]}' == action.selectedMonth) {
  //     selectedIntMonth = ++item;
  //   }
  // }

  // if (selectedIntMonth == 1 ||
  //     selectedIntMonth == 3 ||
  //     selectedIntMonth == 5 ||
  //     selectedIntMonth == 7 ||
  //     selectedIntMonth == 8 ||
  //     selectedIntMonth == 10 ||
  //     selectedIntMonth == 12) {
  //   if (action.selectedDay < 31 && action.selectedDay > 0) {
  //     return date.add(const Duration(days: 1));
  //   } else {
  //     return date;
  //   }
  // } else if (selectedIntMonth == 4 ||
  //     selectedIntMonth == 6 ||
  //     selectedIntMonth == 9 ||
  //     selectedIntMonth == 11) {
  //   if (action.selectedDay < 30 && action.selectedDay > 0) {
  //     return date.add(const Duration(days: 1));
  //   }
  //   else if (action.selectedDay > 30) {
  //     return DateTime(selectedIntYear, selectedIntMonth, 30);
  //   } else {
  //     return date;
  //   }
  // } else {
  //   if ((((selectedIntYear % 4) == 0) && !((selectedIntYear % 100).isNaN)) ||
  //       !((selectedIntYear % 400).isNaN)) {
  //     if (action.selectedDay < 29 && action.selectedDay > 0) {
  //       return date.add(const Duration(days: 1));
  //     } else if (action.selectedDay > 29) {
  //       return DateTime(selectedIntYear, selectedIntMonth, 29);
  //     } else {
  //       return date;
  //     }
  //   } else {
  //     if (action.selectedDay < 28 && action.selectedDay > 0) {
  //       return date.add(const Duration(days: 1));
  //     } else if (action.selectedDay > 28) {
  //       return DateTime(selectedIntYear, selectedIntMonth, 28);
  //     } else {
  //       return date;
  //     }
  //   }
  // }
}

DateTime _resetDayReducer(DateTime date, ResetDayAction action) =>
    DateTime.now();

DateTime _removeDayReducer(DateTime date, RemoveDayAction action) {
  return date.subtract(const Duration(days: 1));
  // if (action.selectedDay > 1) {
  //   return date.subtract(const Duration(days: 1));
  // } else {
  //   return date;
  // }
}

/// Запись нового месяца
DateTime _setRecordMonthReducer(DateTime date, RecordDateMonthAction action) {
  int selectedIntMonth = 1;
  for (var item = 0; item < listMonths.length; item++) {
    if ('${listMonths[item]}' == action.newDateMonth) {
      selectedIntMonth = ++item;
    }
  }
  return DateTime(date.year, selectedIntMonth, date.day);
}

/// Запись нового года
DateTime _setRecordYearReducer(DateTime date, RecordDateYearAction action) {
  return DateTime(action.newDateYear, date.month, date.day);
}
