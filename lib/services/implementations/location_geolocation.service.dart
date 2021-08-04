import 'package:mockup_mail/models/location.dart';
import 'package:mockup_mail/services/geolocation.service.dart';

class LocationGeolocationService implements GeolocationService {
  @override
  Future<Location?> getCurrentLocation() async {
    return Location(123.12, 121.30);
  }
}
