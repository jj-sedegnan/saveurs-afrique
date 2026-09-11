import 'package:flutter/material.dart';

import '../data/categories.dart';

/// Ligne horizontale de [FilterChip] pour filtrer les recettes par
/// catégorie. « Toutes » est systématiquement présent en tête.
class CategoryFilterChips extends StatelessWidget {
  const CategoryFilterChips({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final all = [Categories.all, ...Categories.values];

    return SizedBox(
      height: 52,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: all.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = all[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: FilterChip(
              avatar: Icon(category.icon, size: 18),
              label: Text(category.name),
              selected: selected == category.name,
              onSelected: (_) => onSelected(category.name),
            ),
          );
        },
      ),
    );
  }
}
