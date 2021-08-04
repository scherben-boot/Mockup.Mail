import 'package:mockup_mail/models/report.dart';

abstract class ReportingService {
  Future<void> sendReport(Report report);
}
