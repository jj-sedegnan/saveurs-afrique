import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/recipe.dart';
import '../state/app_state.dart';
import 'gradient_thumbnail.dart';
import 'info_pill.dart';

/// Carte de recette réutilisable : vignette, nom, origine, métadonnées
/// et bouton favori. Utilisée dans l'accueil, la liste et les favoris.
class RecipeCard extends StatelessWidget {
  const RecipeCard({
    super.key,
    required this.recipe,
    this.onTap,
    this.heroTagPrefix = 'liste',
  });

  final Recipe recipe;
  final VoidCallback? onTap;

  /// Préfixe du tag Hero : permet d'avoir des tags uniques même quand
  /// plusieurs écrans gardés en vie par l'IndexedStack affichent la
  /// même recette.
  final String heroTagPrefix;

  String get _heroTag => '$heroTagPrefix-${recipe.id}';

  @override
  Widget build(BuildContext context) {
    final store = context.recipeStore;
    final favorite = store.isFavorite(recipe.id);
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        onTap:
            onTap ??
            () => context.pushNamed(
              'recette',
              pathParameters: {'id': recipe.id},
              extra: _heroTag,
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Hero(
                  tag: _heroTag,
                  child: GradientThumbnail(
                    recipe: recipe,
                    height: 140,
                    width: double.infinity,
                    iconSize: 44,
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: Material(
                    color: Colors.black26,
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: IconButton(
                      tooltip: favorite
                          ? 'Retirer des favoris'
                          : 'Ajouter aux favoris',
                      visualDensity: VisualDensity.compact,
                      iconSize: 20,
                      color: Colors.white,
                      onPressed: () => store.toggleFavorite(recipe.id),
                      icon: Icon(
                        favorite ? Icons.favorite : Icons.favorite_border,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.public,
                        size: 14,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          recipe.country,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.5,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      InfoPill(
                        icon: Icons.schedule,
                        label: recipe.durationLabel,
                      ),
                      InfoPill(
                        icon: Icons.local_fire_department,
                        label: recipe.difficulty.label,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
