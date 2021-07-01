class LocationModel {
  late final String country;
  late final String region;
  late final String street;
  late final String houseNum;
  late final String postalCode;
  late final double latitude;
  late final double longitude;
  late final int hourTime;
  late final int minuteTime;
  late final int secondTime;

  LocationModel({
    required this.country,
    required this.region,
    required this.street,
    required this.houseNum,
    required this.postalCode,
    required this.latitude,
    required this.longitude,
    required this.hourTime,
    required this.minuteTime,
    required this.secondTime,
  });

  LocationModel.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    region = json['region'];
    street = json['street'] ?? '';
    houseNum = json['houseNum'] ?? '';
    postalCode = json['postalCode'];
    latitude = json['latitude'] as double;
    longitude = json['longitude'] as double;
    hourTime = DateTime.now().hour;
    minuteTime = DateTime.now().minute;
    secondTime = DateTime.now().second;
  }
}
