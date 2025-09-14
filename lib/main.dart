import 'package:flutter/material.dart';
import 'package:rick_and_morty/app.dart';
import 'package:rick_and_morty/app_flavor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setPreferences();

  AppFlavor.build(
    name: '',
    baseUrl: 'https://rickandmortyapi.com/api',
  );
  runApp(const MyApp());
}
