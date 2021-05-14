// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotelDetail _$HotelDetailFromJson(Map<String, dynamic> json) {
  return HotelDetail(
    name: json['name'] as String,
    poster: json['poster'] as String,
    price: (json['price'] as num)?.toDouble(),
    rating: (json['rating'] as num)?.toDouble(),
    address: json['address'] == null
        ? null
        : HotelAddress.fromJson(json['address'] as Map<String, dynamic>),
    services: json['services'] == null
        ? null
        : HotelService.fromJson(json['services'] as Map<String, dynamic>),
    photos: (json['photos'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$HotelDetailToJson(HotelDetail instance) =>
    <String, dynamic>{
      'name': instance.name,
      'poster': instance.poster,
      'price': instance.price,
      'rating': instance.rating,
      'address': instance.address,
      'services': instance.services,
      'photos': instance.photos,
    };

HotelAddress _$HotelAddressFromJson(Map<String, dynamic> json) {
  return HotelAddress(
    country: json['country'] as String,
    street: json['street'] as String,
    city: json['city'] as String,
  );
}

Map<String, dynamic> _$HotelAddressToJson(HotelAddress instance) =>
    <String, dynamic>{
      'country': instance.country,
      'street': instance.street,
      'city': instance.city,
    };

HotelService _$HotelServiceFromJson(Map<String, dynamic> json) {
  return HotelService(
    free: (json['free'] as List)?.map((e) => e as String)?.toList(),
    paid: (json['paid'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$HotelServiceToJson(HotelService instance) =>
    <String, dynamic>{
      'free': instance.free,
      'paid': instance.paid,
    };
