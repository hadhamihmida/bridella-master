import 'package:bridella/app_core/services/bridella_settings.dart';
import 'package:bridella/app_core/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import '../widgets/custom_app_bar.dart';

class SettingPage extends StatefulWidget {
  static String routeName = "/settings_page";

  SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<BridellaSettings>(context, listen: false);

    return Scaffold(
      appBar: ClassicAppBar.defaultAppBar(
        context,
        title: 'Settings',
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          PreferenceBuilder(
              preference: settings.darkMode,
              builder: (BuildContext context, bool darkMode) {
                return SwitchListTile.adaptive(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(Icons.wb_sunny_outlined),
                      Text('DarkMode'),
                    ],
                  ),
                  dense: true,
                  activeColor: kPrimaryColor,
                  value: darkMode,
                  onChanged: (value) {
                    settings.darkMode.setValue(value);
                  },
                );
              }),
          ListTile(
            dense: true,
            title: const Text('language', textAlign: TextAlign.right),
            leading: const Icon(Icons.language_outlined),
            trailing: DropdownButton(
              underline: Container(
                color: kPrimaryColor,
                height: 2.0,
              ),
              iconEnabledColor: kPrimaryColor,
              onChanged: (String? value) {},
              items: const [
                DropdownMenuItem(value: 'en', child: Text('English')),
                DropdownMenuItem(value: 'fr', child: Text('Francais')),
                DropdownMenuItem(value: 'de', child: Text('Deutsch')),
                DropdownMenuItem(value: 'ar', child: Text('عربي')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
