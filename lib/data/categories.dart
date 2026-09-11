import 'package:flutter/material.dart';

/// Catégorie de recettes (métadonnée, placée dans la couche données).
@immutable
class RecipeCategory {
  const RecipeCategory(this.name, this.icon, this.hue);

  final String name;
  final IconData icon;
  final int hue;
}

/// Liste des catégories proposées par l'application.
class Categories {
  const Categories._();

  static const RecipeCategory all = RecipeCategory(
    'Toutes',
    Icons.restaurant_menu,
    22,
  );

  static const List<RecipeCategory> values = [
    RecipeCategory('Plats principaux', Icons.restaurant, 22),
    RecipeCategory('Accompagnements', Icons.rice_bowl, 95),
    RecipeCategory('Street food', Icons.tapas, 40),
    RecipeCategory('Desserts', Icons.cake, 320),
    RecipeCategory('Boissons', Icons.local_cafe, 340),
  ];

  static List<String> get names => values.map((c) => c.name).toList();

  static RecipeCategory byName(String name) =>
      values.firstWhere((c) => c.name == name, orElse: () => all);
}
