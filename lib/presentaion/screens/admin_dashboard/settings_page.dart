import 'package:flutter/material.dart';
import 'package:gps_attendance_system/core/models/setting_manager.dart';
import 'package:gps_attendance_system/presentaion/widgets/Factory%20Pattern.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final SettingsManager settingsManager = SettingsManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
        leading: IconButton(
          onPressed: () => settingsManager.goToProfile(context),
          icon: Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            WidgetFactory.createWidget('language'),
            const SizedBox(height: 40),
            WidgetFactory.createWidget('theme'),
          ],
        ),
      ),
    );
  }
}