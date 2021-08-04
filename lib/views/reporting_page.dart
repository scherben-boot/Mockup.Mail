import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:mockup_mail/dependency_injection/container.dart';
import 'package:mockup_mail/models/report.dart';
import 'package:mockup_mail/models/report_type.dart';
import 'package:mockup_mail/services/geolocation.service.dart';
import 'package:mockup_mail/services/image_provider.service.dart';
import 'package:mockup_mail/services/reporting.service.dart';

class ReportingPage extends StatefulWidget {
  final ReportingService _reportingService = container.resolve();
  final ImageProviderService _imageProviderService = container.resolve();
  final GeolocationService _geolocationService = container.resolve();

  ReportingPage({Key? key}) : super(key: key);

  @override
  _ReportingPageState createState() => _ReportingPageState();
}

class _ReportingPageState extends State<ReportingPage> {
  bool _includeLocation = true;
  String? _imagePath;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _updateImagePath(bool includeImage) async {
    if (!includeImage) {
      setState(() {
        _imagePath = null;
      });
      return;
    }
    final imagePath = await widget._imageProviderService.pickImage();
    setState(() {
      _imagePath = imagePath;
    });
  }

  Future<void> _sendReport(ReportType type) async {
    final currentLocation = _includeLocation
        ? await widget._geolocationService.getCurrentLocation()
        : null;
    final report = Report(type, _titleController.text,
        _descriptionController.text, _imagePath, currentLocation);

    await widget._reportingService.sendReport(report);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            "Neue Meldung",
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                CupertinoFormSection(
                  header: Text("Meta-Informationen"),
                  children: [
                    CupertinoFormRow(
                      child: CupertinoSwitch(
                        value: _includeLocation,
                        onChanged: (includeLocation) =>
                            setState(() => _includeLocation = includeLocation),
                      ),
                      prefix: Text("Position einfügen"),
                    ),
                    CupertinoFormRow(
                      child: CupertinoSwitch(
                        value: _imagePath != null,
                        onChanged: (includeImage) =>
                            _updateImagePath(includeImage),
                      ),
                      prefix: Text("Bild einfügen"),
                    ),
                  ],
                ),
                CupertinoFormSection(
                  header: Text("Nachricht"),
                  children: [
                    CupertinoTextField(
                      padding: EdgeInsets.all(16.0),
                      placeholder: "Titel",
                      controller: _titleController,
                    ),
                    CupertinoTextField(
                      padding: EdgeInsets.all(16.0),
                      minLines: 5,
                      maxLines: null,
                      placeholder: "Beschreibung",
                      controller: _descriptionController,
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CupertinoButton(
                          child: Text("Vorschlag senden"),
                          onPressed: () => _sendReport(ReportType.Proposal),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CupertinoButton.filled(
                          child: Text("Gefahrenmeldung"),
                          onPressed: () => _sendReport(ReportType.Incident),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
