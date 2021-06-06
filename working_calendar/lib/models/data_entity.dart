class DataEntity {
  late final int year;
  late final List<Months> months;

  DataEntity({required this.year, required this.months});

  DataEntity.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    if (json['months'] != null) {
      months = <Months>[];
      json['months'].forEach((v) {
        months.add(new Months.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['year'] = this.year;
    data['months'] = this.months.map((v) => v.toJson()).toList();
    return data;
  }
}

class Months {
  late final int month;
  late final List<int> days;

  Months({required this.month, required this.days});

  Months.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    days = json['days'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['month'] = this.month;
    data['days'] = this.days;
    return data;
  }
}
