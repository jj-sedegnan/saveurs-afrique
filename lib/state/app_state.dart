import 'package:flutter/material.dart';

import '../data/recipe_repository.dart';
import '../models/recipe.dart';

/// Gère le mode de thème (système / clair / sombre).
class ThemeController extends ChangeNotifier {
  ThemeController([this._mode = ThemeMode.system]);

  ThemeMode _mode;
  ThemeMode get mode => _mode;

  set mode(ThemeMode value) {
    if (_mode == value) return;
    _mode = value;
    notifyListeners();
  }
}

/// Magasin applicatif : recettes (initiales + celles créées par
/// l'utilisateur) et favoris. Sépare clairement les données des widgets.
class RecipeStore extends ChangeNotifier {
  RecipeStore(this._repository);

  final RecipeRepository _repository;
  final List<Recipe> _userRecipes = [];
  final Set<String> _favoriteIds = {'yassa', 'bissap'};

  List<Recipe> get all => [..._repository.fetchAll(), ..._userRecipes];

  Recipe? findById(String id) {
    for (final recipe in all) {
      if (recipe.id == id) return recipe;
    }
    return null;
  }

  List<Recipe> get favorites =>
      all.where((r) => _favoriteIds.contains(r.id)).toList();

  bool isFavorite(String id) => _favoriteIds.contains(id);

  int get favoriteCount => _favoriteIds.length;

  void toggleFavorite(String id) {
    if (!_favoriteIds.remove(id)) _favoriteIds.add(id);
    notifyListeners();
  }

  /// Recherche par texte (nom, pays, description, ingrédients) avec filtre
  /// optionnel sur la catégorie.
  List<Recipe> search({String query = '', String? category}) {
    final q = query.trim().toLowerCase();
    return all.where((recipe) {
      if (category != null &&
          category != 'Toutes' &&
          recipe.category != category) {
        return false;
      }
      if (q.isEmpty) return true;
      final haystack = [
        recipe.name,
        recipe.country,
        recipe.description,
        recipe.ingredients.join(' '),
      ].join(' ').toLowerCase();
      return haystack.contains(q);
    }).toList();
  }

  /// Ajoute une recette saisie via le formulaire et retourne l'instance
  /// créée (avec un identifiant unique).
  Recipe addRecipe({
    required String name,
    required String country,
    required String category,
    required String description,
    required int minutes,
    required int servings,
    required Difficulty difficulty,
    required List<String> ingredients,
    required List<String> steps,
  }) {
    final recipe = Recipe(
      id: 'recette-${DateTime.now().microsecondsSinceEpoch}',
      name: name.trim(),
      country: country.trim(),
      category: category,
      description: description.trim().isEmpty
          ? 'Une recette maison ajoutée depuis l\u0027application.'
          : description.trim(),
      minutes: minutes,
      servings: servings,
      difficulty: difficulty,
      ingredients: ingredients,
      steps: steps,
      icon: Icons.restaurant,
      hue: name.trim().hashCode.abs() % 360,
    );
    _userRecipes.add(recipe);
    notifyListeners();
    return recipe;
  }
}

/// Implémentation concrète d'[InheritedNotifier] (devenue abstraite) pour
/// exposer un contrôleur dans l'arbre des widgets.
class ListenableScope<T extends Listenable> extends InheritedNotifier<T> {
  const ListenableScope({super.key, required T notifier, required super.child})
    : super(notifier: notifier);

  @override
  bool updateShouldNotify(ListenableScope<T> oldWidget) =>
      notifier != oldWidget.notifier;
}

/// Accès simplifié aux contrôleurs depuis l'arbre des widgets.
extension AppStateContext on BuildContext {
  RecipeStore get recipeStore {
    final widget =
        dependOnInheritedWidgetOfExactType<ListenableScope<RecipeStore>>();
    assert(widget != null, 'RecipeStore introuvable dans l\u2019arbre');
    return widget!.notifier!;
  }

  ThemeController get themeController {
    final widget =
        dependOnInheritedWidgetOfExactType<ListenableScope<ThemeController>>();
    assert(widget != null, 'ThemeController introuvable dans l\u2019arbre');
    return widget!.notifier!;
  }
}
