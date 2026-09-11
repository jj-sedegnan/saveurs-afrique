import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../state/app_state.dart';
import '../widgets/empty_state.dart';
import '../widgets/responsive_recipe_view.dart';

/// Écran des recettes favorites.
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.recipeStore.favorites;

    return Scaffold(
      appBar: AppBar(title: const Text('Mes favoris')),
      body: favorites.isEmpty
          ? EmptyState(
              icon: Icons.favorite_border,
              title: 'Aucun favori pour le moment',
              message:
                  'Touchez le cœur sur une recette pour la retrouver ici, '
                  'même hors ligne.',
              action: FilledButton.icon(
                onPressed: () => context.goNamed('recettes'),
                icon: const Icon(Icons.restaurant_menu),
                label: const Text('Parcourir les recettes'),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
                  child: Text(
                    '${favorites.length} recette${favorites.length > 1 ? 's' : ''} sauvegardée${favorites.length > 1 ? 's' : ''}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                Expanded(
                  child: ResponsiveRecipeView(
                    recipes: favorites,
                    heroTagPrefix: 'favoris',
                  ),
                ),
              ],
            ),
    );
  }
}
