import 'package:kiwi/kiwi.dart';
import 'package:mockup_mail/dependency_injection/module.dart';
import 'package:mockup_mail/services/geolocation.service.dart';
import 'package:mockup_mail/services/image_provider.service.dart';
import 'package:mockup_mail/services/reporting.service.dart';
import 'package:mockup_mail/services/implementations/email_reporting.service.dart';
import 'package:mockup_mail/services/implementations/image_picker_image_provider.service.dart';
import 'package:mockup_mail/services/implementations/location_geolocation.service.dart';

class ServicesModule implements Module {
  @override
  void registerModule(KiwiContainer container) {
    container.registerSingleton<GeolocationService>(
        (container) => LocationGeolocationService());
    container.registerSingleton<ImageProviderService>(
        (container) => ImagePickerImageProviderService());
    container.registerSingleton<ReportingService>(
        (container) => EmailReportingService());
  }
}
