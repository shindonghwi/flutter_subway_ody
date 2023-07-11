import 'package:flutter/material.dart';
import 'package:subway_ody/domain/models/local/LatLng.dart';

class MapAppBarModel {
  String hosun;
  String subwayName;
  Color mainColor;
  String distance;
  LatLng latLng;

  MapAppBarModel({
    required this.subwayName,
    required this.hosun,
    required this.mainColor,
    required this.distance,
    required this.latLng,
  });
}
