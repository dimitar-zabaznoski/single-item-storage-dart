// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_classes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Place _$PlaceFromJson(Map<String, dynamic> json) {
  return Place(
    json['placeName'] as String,
    json['coordinates'] == null
        ? null
        : Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
    nearbyGasPumps:
    (json['nearbyGasPumps'] as List<dynamic>).map((e) => e as String),
    nearbyMcDonalds:
    (json['nearbyMcDonalds'] as List<dynamic>).map((e) => e as bool),
    nearbyToilets: (json['nearbyToilets'] as List<dynamic>)
        .map((e) => Coordinates.fromJson(e as Map<String, dynamic>)),
  );
}

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
  'placeName': instance.placeName,
  'coordinates': instance.coordinates,
  'nearbyMcDonalds': instance.nearbyMcDonalds,
  'nearbyGasPumps': instance.nearbyGasPumps,
  'nearbyToilets': instance.nearbyToilets,
};

Coordinates _$CoordinatesFromJson(Map<String, dynamic> json) {
  return Coordinates(
    (json['latitude'] as num).toDouble(),
    (json['longitude'] as num).toDouble(),
  );
}

Map<String, dynamic> _$CoordinatesToJson(Coordinates instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
