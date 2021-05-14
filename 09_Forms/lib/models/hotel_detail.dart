import 'package:json_annotation/json_annotation.dart';

part 'hotel_detail.g.dart';

@JsonSerializable()
class HotelDetail {
  final String name;
  final String poster;
  final double price;
  final double rating;
  final HotelAddress address;
  final HotelService services;
  final List<String> photos;

  HotelDetail({
    this.name,
    this.poster,
    this.price,
    this.rating,
    this.address,
    this.services,
    this.photos,
  });

  factory HotelDetail.fromJson(Map<String, dynamic> json) =>
      _$HotelDetailFromJson(json);

  Map<String, dynamic> toJson() => _$HotelDetailToJson(this);
}

@JsonSerializable()
class HotelAddress {
  final String country;
  final String street;
  final String city;
  HotelAddress({
    this.country,
    this.street,
    this.city,
  });

  factory HotelAddress.fromJson(Map<String, dynamic> json) =>
      _$HotelAddressFromJson(json);
  Map<String, dynamic> toJson() => _$HotelAddressToJson(this);
}

@JsonSerializable()
class HotelService {
  final List<String> free;
  final List<String> paid;
  HotelService({
    this.free,
    this.paid,
  });
  factory HotelService.fromJson(Map<String, dynamic> json) =>
      _$HotelServiceFromJson(json);
  Map<String, dynamic> toJson() => _$HotelServiceToJson(this);
}
