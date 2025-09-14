
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/features/characters/core/characters_routes.dart';

import 'package:shared_preferences/shared_preferences.dart';



GoRouter router(SharedPreferences preferences) {
 

  return GoRouter(
    
    routes: [
      ...CharactersRoutes.routes,
     
      
    ],
  );
}
