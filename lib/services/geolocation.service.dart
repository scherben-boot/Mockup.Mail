import 'package:mockup_mail/models/location.dart';

abstract class GeolocationService {
  Future<Location?> getCurrentLocation();
}
