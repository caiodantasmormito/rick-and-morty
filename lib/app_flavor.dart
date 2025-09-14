import 'package:shared_preferences/shared_preferences.dart';

class AppFlavor {
  final String name;
  final String baseUrl;

  AppFlavor({required this.name, required this.baseUrl});

  factory AppFlavor.build({String name = '', String baseUrl = ''}) {
    return shared = AppFlavor(name: name, baseUrl: baseUrl);
  }

  static AppFlavor shared = AppFlavor.build();
}

late final SharedPreferences preferences;

Future<void> setPreferences() async {
  preferences = await SharedPreferences.getInstance();
}
