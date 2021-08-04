import 'package:location/location.dart';
import 'package:mockup_mail/models/location.dart';
import 'package:mockup_mail/services/geolocation.service.dart';

class LocationGeolocationService implements GeolocationService {
  @override
  Future<Point?> getCurrentLocation() async {
    Location location = new Location();

    bool _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    PermissionStatus _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    LocationData _locationData = await location.getLocation();
    return Point(_locationData.longitude!, _locationData.latitude!);
  }
}
