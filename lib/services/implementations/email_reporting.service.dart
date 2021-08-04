import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:mockup_mail/models/report.dart';
import 'package:mockup_mail/models/report_type.dart';
import 'package:mockup_mail/services/reporting.service.dart';

class EmailReportingService implements ReportingService {
  @override
  Future<void> sendReport(Report report) async {
    final subject =
        (report.type == ReportType.Incident ? "[INCIDENT] " : "[PROPOSAL] ") +
            report.title;
    final String locationString = report.reportedLocation != null
        ? """Ermittelter Ort:
    Longitude: ${report.reportedLocation!.longitude},
    Latitude: ${report.reportedLocation!.latitude}"""
        : "";
    final body = """${report.description}
    
    $locationString""";
    final email = Email(
        attachmentPaths:
            report.imageLocation != null ? [report.imageLocation!] : null,
        body: body,
        isHTML: false,
        recipients: ["schmidlu@dhbw-loerrach.de", "sommeref@dhbw-loerrach.de"],
        subject: subject);

    await FlutterEmailSender.send(email);
  }
}
