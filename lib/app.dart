import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'data/recipe_repository.dart';
import 'router/app_router.dart';
import 'state/app_state.dart';
import 'theme/app_theme.dart';

/// Point d'entrée de l'application : crée les contrôleurs d'état,
/// les expose dans l'arbre via des [InheritedNotifier], puis construit
/// le [MaterialApp.router].
class SaveursApp extends StatefulWidget {
  const SaveursApp({super.key});

  @override
  State<SaveursApp> createState() => _SaveursAppState();
}

class _SaveursAppState extends State<SaveursApp> {
  late final RecipeStore _recipeStore;
  late final ThemeController _themeController;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    final repository = InMemoryRecipeRepository();
    _recipeStore = RecipeStore(repository);
    _themeController = ThemeController();
    _router = buildAppRouter();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableScope<ThemeController>(
      notifier: _themeController,
      child: ListenableScope<RecipeStore>(
        notifier: _recipeStore,
        child: Builder(
          builder: (context) {
            // Souscrire aux changements de thème via l'InheritedNotifier.
            final themeController = context.themeController;
            return MaterialApp.router(
              title: 'Saveurs d\u2019Afrique',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: themeController.mode,
              routerConfig: _router,
            );
          },
        ),
      ),
    );
  }
}
