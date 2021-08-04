import 'package:mockup_mail/models/location.dart';
import 'package:mockup_mail/models/report_type.dart';

class Report {
  final ReportType type;
  final String title;
  final String description;
  final String? imageLocation;
  final Location? reportedLocation;

  Report(this.type, this.title, this.description, this.imageLocation,
      this.reportedLocation);
}
