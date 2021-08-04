import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mockup_mail/dependency_injection/container.dart';
import 'package:mockup_mail/services/services.module.dart';
import 'package:mockup_mail/views/reporting_page.dart';

void main() {
  container.addModule(ServicesModule());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: const CupertinoThemeData(brightness: Brightness.light),
      home: ReportingPage(),
    );
  }
}
