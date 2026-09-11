import 'package:flutter/material.dart';

import '../data/categories.dart';
import '../state/app_state.dart';
import '../widgets/empty_state.dart';
import '../widgets/gradient_thumbnail.dart';
import '../widgets/info_pill.dart';
import '../widgets/section_title.dart';

/// Écran de détail. L'identifiant de la recette est reçu en paramètre de
/// route (/recette/:id) ; la recette est ensuite résolue via le store.
class RecipeDetailScreen extends StatelessWidget {
  const RecipeDetailScreen({super.key, required this.recipeId, this.heroTag});

  /// Tag Hero transmis par la carte source (paramètre de navigation).
  final String? heroTag;

  final String recipeId;

  @override
  Widget build(BuildContext context) {
    final recipe = context.recipeStore.findById(recipeId);

    if (recipe == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Recette introuvable')),
        body: EmptyState(
          icon: Icons.sentiment_dissatisfied,
          title: 'Recette introuvable',
          message: 'Cette recette n\u2019existe pas (id : $recipeId).',
        ),
      );
    }

    final store = context.recipeStore;
    final favorite = store.isFavorite(recipe.id);
    final category = Categories.byName(recipe.category);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 300,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton.filledTonal(
                  tooltip: favorite
                      ? 'Retirer des favoris'
                      : 'Ajouter aux favoris',
                  onPressed: () => store.toggleFavorite(recipe.id),
                  icon: Icon(favorite ? Icons.favorite : Icons.favorite_border),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsetsDirectional.only(
                start: 52,
                bottom: 14,
                end: 64,
              ),
              title: Text(
                recipe.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(blurRadius: 8, color: Colors.black54)],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: heroTag ?? 'recette-${recipe.id}',
                    child: GradientThumbnail(recipe: recipe, iconSize: 90),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                        colors: [
                          Colors.black.withValues(alpha: 0.55),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            category.icon,
                            size: 18,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            recipe.category,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.public, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            recipe.country,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          InfoPill(
                            icon: Icons.schedule,
                            label: recipe.durationLabel,
                          ),
                          InfoPill(
                            icon: Icons.group,
                            label:
                                '${recipe.servings} part${recipe.servings > 1 ? 's' : ''}',
                          ),
                          InfoPill(
                            icon: Icons.local_fire_department,
                            label: recipe.difficulty.label,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        recipe.description,
                        style: const TextStyle(height: 1.5, fontSize: 15),
                      ),
                      const SizedBox(height: 28),
                      SectionTitle(
                        title: 'Ingrédients (${recipe.ingredients.length})',
                      ),
                      const SizedBox(height: 8),
                      ...recipe.ingredients.map(
                        (ingredient) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                size: 19,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 10),
                              Expanded(child: Text(ingredient)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      SectionTitle(
                        title: 'Préparation (${recipe.steps.length} étapes)',
                      ),
                      const SizedBox(height: 8),
                      ...recipe.steps.asMap().entries.map((entry) {
                        final index = entry.key;
                        final step = entry.value;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 14,
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  step,
                                  style: const TextStyle(height: 1.45),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 28),
                      FilledButton.icon(
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(48),
                        ),
                        onPressed: () => store.toggleFavorite(recipe.id),
                        icon: Icon(
                          favorite ? Icons.heart_broken : Icons.favorite,
                        ),
                        label: Text(
                          favorite
                              ? 'Retirer des favoris'
                              : 'Ajouter aux favoris',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
