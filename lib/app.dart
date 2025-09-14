import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/app_flavor.dart';
import 'package:rick_and_morty/core/infra/http_client.dart';
import 'package:rick_and_morty/features/characters/core/characters_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => HttpClient(),
        ),
        Provider<SharedPreferences>(
          create: (context) => preferences,
        ),
        Provider(
          create: (context) => AuthenticatedClient(
            sharedPreferences: context.read<SharedPreferences>(),
          ),
        ),
        ...CharactersInject.providers,
        
      ],
      child: MaterialApp.router(
        title: 'Rick and Morty',
        debugShowCheckedModeBanner: false,
        routerConfig: router(preferences),
      ),
    );
  }
}
