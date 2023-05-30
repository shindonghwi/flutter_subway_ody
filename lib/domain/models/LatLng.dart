import 'package:json_annotation/json_annotation.dart';

part 'LatLng.g.dart';
@JsonSerializable()
class LatLng{
  final double? latitude;
  final double? longitude;

  LatLng(this.latitude, this.longitude);

  @override
  String toString() {
    return 'LatLng{latitude: $latitude, longitude: $longitude}';
  }
}