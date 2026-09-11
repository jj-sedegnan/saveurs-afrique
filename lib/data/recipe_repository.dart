import '../models/recipe.dart';
import 'seed_recipes.dart';

/// Contrat d'accès aux recettes (on pourrait avoir une version API plus tard).
abstract class RecipeRepository {
  List<Recipe> fetchAll();
  Recipe? findById(String id);
}

/// Repository en mémoire à partir du jeu de données de départ.
class InMemoryRecipeRepository implements RecipeRepository {
  InMemoryRecipeRepository({List<Recipe>? seed}) : _seed = seed ?? kSeedRecipes;

  final List<Recipe> _seed;

  @override
  List<Recipe> fetchAll() => List<Recipe>.unmodifiable(_seed);

  @override
  Recipe? findById(String id) {
    for (final recipe in _seed) {
      if (recipe.id == id) return recipe;
    }
    return null;
  }
}
