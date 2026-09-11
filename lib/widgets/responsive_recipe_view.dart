import 'package:flutter/material.dart';

import '../models/recipe.dart';
import 'app_shell.dart';
import 'recipe_card.dart';

/// Liste / grille de recettes qui s'adapte à la largeur disponible :
/// - mobile : [ListView] vertical ;
/// - tablette : [GridView] à 2 ou 3 colonnes.
///
/// Réutilisée par l'écran de recherche et l'écran des favoris.
class ResponsiveRecipeView extends StatelessWidget {
  const ResponsiveRecipeView({
    super.key,
    required this.recipes,
    this.heroTagPrefix = 'grille',
  });

  final List<Recipe> recipes;
  final String heroTagPrefix;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        if (width < kTabletBreakpoint) {
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            itemCount: recipes.length,
            separatorBuilder: (_, _) => const SizedBox(height: 14),
            itemBuilder: (_, i) =>
                RecipeCard(recipe: recipes[i], heroTagPrefix: heroTagPrefix),
          );
        }

        final columns = (width ~/ 360).clamp(2, 3);
        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          itemCount: recipes.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.22,
          ),
          itemBuilder: (_, i) =>
              RecipeCard(recipe: recipes[i], heroTagPrefix: heroTagPrefix),
        );
      },
    );
  }
}
