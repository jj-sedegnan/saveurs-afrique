import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/add_recipe_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/home_screen.dart';
import '../screens/recipe_detail_screen.dart';
import '../screens/recipes_screen.dart';
import '../screens/settings_screen.dart';
import '../widgets/app_shell.dart';

/// Configuration de la navigation avec GoRouter (Navigator 2.0) et
/// routes nommées. Les 4 sections principales sont dans une
/// [StatefulShellRoute] (barre en bas sur mobile, rail sur tablette) ;
/// le détail et le formulaire s'ouvrent par-dessus.
GoRouter buildAppRouter() {
  return GoRouter(
    initialLocation: '/accueil',
    debugLogDiagnostics: false,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: 'accueil',
                path: '/accueil',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: 'recettes',
                path: '/recettes',
                builder: (context, state) => const RecipesScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: 'favoris',
                path: '/favoris',
                builder: (context, state) => const FavoritesScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: 'reglages',
                path: '/reglages',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        name: 'recette',
        path: '/recette/:id',
        builder: (context, state) => RecipeDetailScreen(
          recipeId: state.pathParameters['id']!,
          heroTag: state.extra as String?,
        ),
      ),
      GoRoute(
        name: 'ajouter',
        path: '/ajouter',
        pageBuilder: (context, state) => const MaterialPage(
          fullscreenDialog: true,
          child: AddRecipeScreen(),
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Page introuvable')),
      body: Center(child: Text(state.error?.toString() ?? 'Erreur de route')),
    ),
  );
}
