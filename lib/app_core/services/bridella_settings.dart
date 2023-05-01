import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class BridellaSettings {
  BridellaSettings(StreamingSharedPreferences preferences)
      : darkMode = preferences.getBool('darkMode', defaultValue: false),
        language = preferences.getString('language', defaultValue: 'en'),
        onBoarding = preferences.getBool('onBoarding', defaultValue: true),
        firstLogin = preferences.getBool('firstLogin', defaultValue: true),
        flagedItems =
            preferences.getStringList('flagedItems', defaultValue: []),
        completedItems =
            preferences.getStringList('completedItems', defaultValue: []);

  final Preference<bool> darkMode;
  final Preference<String> language;
  final Preference<bool> onBoarding;
  final Preference<bool> firstLogin;
  final Preference<List<String>> flagedItems;
  final Preference<List<String>> completedItems;
}
