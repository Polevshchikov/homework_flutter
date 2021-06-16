class AppState {
  final DateTime rangeStartDate;
  final DateTime rangeEndDate;
  final int studyingTime;
  final bool isSwitchedOn;

  AppState({
    required this.studyingTime,
    required this.isSwitchedOn,
    required this.rangeStartDate,
    required this.rangeEndDate,
  });
}
