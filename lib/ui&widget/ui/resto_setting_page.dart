import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restauranttt_sub3_rev3/provider&utils/restoprov/preference_provider.dart';
import 'package:restauranttt_sub3_rev3/provider&utils/restoprov/scheduling_provider.dart';
import 'package:restauranttt_sub3_rev3/ui&widget/widget/plat_widget.dart';
import 'package:restauranttt_sub3_rev3/ui&widget/widget/custom_dialog.dart';

class RestoSettingPage extends StatelessWidget {
  static const String settingsTitle = 'Settings';
  static const String routeName = '/resto_setting_page';

  const RestoSettingPage({Key? key}) : super(key: key);

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(settingsTitle),
      ),
      resizeToAvoidBottomInset: true,
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(settingsTitle),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<PreferenceProvider>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            Material(
              child: ListTile(
                title: const Text('Dark Theme'),
                trailing: Switch.adaptive(
                    value: provider.isDarkTheme,
                    onChanged: (value) {
                      provider.enableDarkTheme(value);
                    }),
              ),
            ),
            Material(
              child: ListTile(
                title: const Text('Notification'),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                        value: scheduled.isScheduled,
                        onChanged: (value) async {
                          if (Platform.isIOS) {
                            customDialog(context);
                          } else {
                            scheduled.scheduledReminder(value);
                          }
                        });
                  },
                ),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
