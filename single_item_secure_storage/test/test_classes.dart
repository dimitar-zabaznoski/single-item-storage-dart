import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'test_classes.g.dart';

/// Nested test class.
@JsonSerializable()
class Place extends Equatable {
  final String placeName;
  final Coordinates? coordinates;
  final List<bool> nearbyMcDonalds;
  final List<String> nearbyGasPumps;
  final List<Coordinates> nearbyToilets;

  factory Place.fromJson(Map<String, dynamic> json) => Place.fromMap(json);

  factory Place.fromMap(Map<String, dynamic> map) => _$PlaceFromJson(map);

  Map<String, dynamic> toJson() => toMap();

  Map<String, dynamic> toMap() => _$PlaceToJson(this);

  Place(
      this.placeName,
      this.coordinates, {
        required Iterable<String> nearbyGasPumps,
        required Iterable<bool> nearbyMcDonalds,
        required Iterable<Coordinates> nearbyToilets,
      })   : this.nearbyGasPumps = nearbyGasPumps.toList(growable: false),
        this.nearbyMcDonalds = nearbyMcDonalds.toList(growable: false),
        this.nearbyToilets = nearbyToilets.toList(growable: false);

  @override
  List<Object?> get props => [
    placeName,
    coordinates,
    nearbyMcDonalds,
    nearbyGasPumps,
    nearbyToilets,
  ];
}

/// Test class.
@JsonSerializable()
class Coordinates extends Equatable {
  final double latitude;
  final double longitude;

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);

  Coordinates(this.latitude, this.longitude);

  @override
  List<Object?> get props => [latitude, longitude];
}
