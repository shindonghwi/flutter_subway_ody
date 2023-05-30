import 'package:location/location.dart';

class LocalGpsApi {
  LocalGpsApi();

  Future<bool> getLocationPermission() async {
    Location location = Location();

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.granted) {
      return true;
    } else {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return false;
        }
      }

      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      }

      return true;
    }
  }
}
