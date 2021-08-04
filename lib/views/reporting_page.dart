import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class ReportingPage extends StatefulWidget {
  const ReportingPage({Key? key}) : super(key: key);

  @override
  _ReportingPageState createState() => _ReportingPageState();
}

class _ReportingPageState extends State<ReportingPage> {
  bool _includeLocation = true;
  String? _imagePath;
  String? _title;

  Future<void> _updateImagePath(bool includeImage) async {
    if (!includeImage) {
      setState(() {
        _imagePath = null;
      });
      return;
    }
    final picker = ImagePicker();
    PickedFile? pick = await picker.getImage(source: ImageSource.camera);
    if (pick != null) {
      setState(() {
        _imagePath = pick.path;
      });
    }
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
            child: Column(
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
                    ),
                    CupertinoTextField(
                      padding: EdgeInsets.all(16.0),
                      minLines: 5,
                      maxLines: null,
                      placeholder: "Beschreibung",
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
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CupertinoButton.filled(
                          child: Text("Gefahrenmeldung"),
                          onPressed: () {},
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
