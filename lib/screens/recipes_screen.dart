import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/recipe.dart';
import '../state/app_state.dart';
import '../widgets/category_filter_chips.dart';
import '../widgets/empty_state.dart';
import '../widgets/responsive_recipe_view.dart';

/// Écran de liste : recherche textuelle et filtrage par catégorie,
/// avec une vue Liste (mobile) / Grille (tablette).
class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  String _query = '';
  String _category = 'Toutes';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _syncCategoryFromRoute() {
    final param = GoRouterState.of(context).uri.queryParameters['category'];
    if (param != null && param != _category) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _category = param);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _syncCategoryFromRoute();
    final store = context.recipeStore;
    final results = store.search(query: _query, category: _category);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recettes'),
        actions: [
          IconButton(
            tooltip: 'Ajouter une recette',
            icon: const Icon(Icons.add_circle_outline),
            onPressed: _openAddRecipe,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddRecipe,
        icon: const Icon(Icons.add),
        label: const Text('Ajouter'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _query = v),
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Rechercher un plat, un pays, un ingrédient…',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _query = '');
                        },
                      ),
              ),
            ),
          ),
          CategoryFilterChips(
            selected: _category,
            onSelected: (c) => setState(() => _category = c),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
            child: Text(
              '${results.length} recette${results.length > 1 ? 's' : ''}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Expanded(child: _results(results)),
        ],
      ),
    );
  }

  Widget _results(List<Recipe> results) {
    if (results.isEmpty) {
      return EmptyState(
        icon: Icons.search_off,
        title: 'Aucune recette trouvée',
        message:
            'Essayez un autre mot-clé ou changez de catégorie. Vous pouvez '
            'aussi ajouter votre propre recette !',
        action: FilledButton.icon(
          onPressed: _openAddRecipe,
          icon: const Icon(Icons.add),
          label: const Text('Ajouter une recette'),
        ),
      );
    }
    return ResponsiveRecipeView(recipes: results, heroTagPrefix: 'recettes');
  }

  Future<void> _openAddRecipe() async {
    final created = await context.pushNamed<Recipe>('ajouter');
    if (!mounted || created == null) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('« ${created.name} » a été ajoutée avec succès !'),
        action: SnackBarAction(
          label: 'Voir',
          onPressed: () =>
              context.pushNamed('recette', pathParameters: {'id': created.id}),
        ),
      ),
    );
  }
}
