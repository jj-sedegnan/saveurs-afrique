import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/categories.dart';
import '../models/recipe.dart';
import '../state/app_state.dart';
import '../widgets/recipe_card.dart';
import '../widgets/section_title.dart';

/// Écran d'accueil : en-tête immersif, catégories, recettes populaires et
/// créations de l'utilisateur.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.recipeStore;
    final popular = store.all.take(8).toList();
    final myCreations = store.all
        .where((r) => r.id.startsWith('recette-'))
        .toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: _HomeHeader()),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                SectionTitle(title: 'Explorer par catégorie'),
                const SizedBox(height: 12),
                const _CategoryRail(),
                const SizedBox(height: 24),
                SectionTitle(
                  title: 'Recettes populaires',
                  actionLabel: 'Voir tout',
                  onAction: () => context.goNamed('recettes'),
                ),
              ]),
            ),
          ),
          SliverToBoxAdapter(
            child: _HorizontalRecipes(
              recipes: popular,
              heroTagPrefix: 'accueil-pop',
            ),
          ),
          if (myCreations.isNotEmpty) ...[
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              sliver: SliverToBoxAdapter(
                child: SectionTitle(title: 'Mes créations'),
              ),
            ),
            SliverToBoxAdapter(
              child: _HorizontalRecipes(
                recipes: myCreations,
                heroTagPrefix: 'accueil-miennes',
              ),
            ),
          ],
          const SliverPadding(
            padding: EdgeInsets.only(top: 12, bottom: 28),
            sliver: SliverToBoxAdapter(child: _HomeFooter()),
          ),
        ],
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        Container(
          height: 250,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [scheme.primary, scheme.tertiary],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -30,
                top: -20,
                child: Icon(
                  Icons.ramen_dining,
                  size: 200,
                  color: Colors.white.withValues(alpha: 0.12),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  20,
                  MediaQuery.of(context).padding.top + 28,
                  20,
                  0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Saveurs d\u2019Afrique',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Voyagez à travers les recettes emblématiques\n'
                      'du continent, du yassa au bissap.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.92),
                        fontSize: 13.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 16,
          right: 16,
          bottom: 0,
          child: Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => context.goNamed('recettes'),
              child: InputDecorator(
                decoration: InputDecoration(
                  hintText: 'Rechercher un plat, un pays…',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: scheme.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CategoryRail extends StatelessWidget {
  const _CategoryRail();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 104,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: Categories.values.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final category = Categories.values[index];
          final start = HSLColor.fromAHSL(
            1,
            category.hue.toDouble(),
            0.7,
            0.6,
          ).toColor();
          final end = HSLColor.fromAHSL(
            1,
            (category.hue + 22) % 360,
            0.65,
            0.38,
          ).toColor();

          return InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () => context.goNamed(
              'recettes',
              queryParameters: {'category': category.name},
            ),
            child: Container(
              width: 108,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: LinearGradient(
                  colors: [start, end],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(category.icon, color: Colors.white),
                  Text(
                    category.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.5,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HorizontalRecipes extends StatelessWidget {
  const _HorizontalRecipes({
    required this.recipes,
    required this.heroTagPrefix,
  });

  final List<Recipe> recipes;
  final String heroTagPrefix;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 286,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: recipes.length,
        separatorBuilder: (_, _) => const SizedBox(width: 14),
        itemBuilder: (_, i) => SizedBox(
          width: 264,
          child: RecipeCard(recipe: recipes[i], heroTagPrefix: heroTagPrefix),
        ),
      ),
    );
  }
}

class _HomeFooter extends StatelessWidget {
  const _HomeFooter();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.restaurant,
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 6),
          Text(
            'Cuisiné avec Flutter & GoRouter',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
