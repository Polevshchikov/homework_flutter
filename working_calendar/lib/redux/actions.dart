import 'package:working_calendar/models/date_entity.dart';

/// Добавление +1 день
class AddDayAction {}

/// Добавление -1 день
class RemoveDayAction {}

/// Сбросить день до настоящего
class ResetDayAction {}

/// Переключение 4 - 6 часов
class SwitchToggleAction {
  final bool isSwitchedOn;

  SwitchToggleAction({required this.isSwitchedOn});
}

/// Генерация даты начала обучения
class GenerateEndDateAction {
  final bool isSwitchedOn;
  final int studyingTime;
  final int selectedDay;
  final String selectedMonth;
  final String selectedYear;
  final DateEntity dateEntity;

  GenerateEndDateAction({
    required this.dateEntity,
    required this.isSwitchedOn,
    required this.studyingTime,
    required this.selectedDay,
    required this.selectedMonth,
    required this.selectedYear,
  });
}

/// Запись времени обучения
class InputStudyingTimeAction {
  final int studyingTime;

  InputStudyingTimeAction({required this.studyingTime});
}

/// Запись нового года
class RecordDateYearAction {
  final int newDateYear;

  RecordDateYearAction({required this.newDateYear});
}

/// Сбросить год до настоящего
class ResetDateYearAction {}

/// Запись нового месяца
class RecordDateMonthAction {
  final String newDateMonth;

  RecordDateMonthAction({required this.newDateMonth});
}

/// Сбросить месяц до настоящего
class ResetDateMonthAction {}
