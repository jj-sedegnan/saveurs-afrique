import 'package:flutter/material.dart';

/// Niveaux de difficulté d'une recette.
enum Difficulty {
  easy('Facile'),
  medium('Moyen'),
  hard('Difficile');

  const Difficulty(this.label);

  final String label;

  static Difficulty fromLabel(String label) => Difficulty.values.firstWhere(
    (d) => d.label == label,
    orElse: () => Difficulty.easy,
  );
}

/// Modèle métier décrivant une recette de cuisine.
///
/// Les données sont entièrement contenues dans ce modèle : les widgets ne
/// contiennent aucune recette en dur.
@immutable
class Recipe {
  const Recipe({
    required this.id,
    required this.name,
    required this.country,
    required this.category,
    required this.description,
    required this.minutes,
    required this.servings,
    required this.difficulty,
    required this.ingredients,
    required this.steps,
    required this.icon,
    required this.hue,
  });

  final String id;
  final String name;
  final String country;
  final String category;
  final String description;
  final int minutes;
  final int servings;
  final Difficulty difficulty;
  final List<String> ingredients;
  final List<String> steps;

  /// Icône affichée dans la vignette (visuel de la recette, sans image réseau).
  final IconData icon;

  /// Teinte (0-360) utilisée pour générer le dégradé de la vignette.
  final int hue;

  /// Étiquette lisible de la durée, ex. « 1 h 15 ».
  String get durationLabel {
    if (minutes < 60) return '$minutes min';
    final h = minutes ~/ 60;
    final m = minutes % 60;
    return m == 0 ? '$h h' : '$h h ${m.toString().padLeft(2, '0')}';
  }

  Recipe copyWith({required String id}) => Recipe(
    id: id,
    name: name,
    country: country,
    category: category,
    description: description,
    minutes: minutes,
    servings: servings,
    difficulty: difficulty,
    ingredients: ingredients,
    steps: steps,
    icon: icon,
    hue: hue,
  );
}
