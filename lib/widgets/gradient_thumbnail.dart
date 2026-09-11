import 'package:flutter/material.dart';

import '../models/recipe.dart';

/// Vignette visuelle d'une recette : dégradé généré depuis [Recipe.hue]
/// avec l'icône de la recette par-dessus (aucune image réseau nécessaire).
class GradientThumbnail extends StatelessWidget {
  const GradientThumbnail({
    super.key,
    required this.recipe,
    this.width,
    this.height,
    this.iconSize = 40,
    this.borderRadius,
  });

  final Recipe recipe;
  final double? width;
  final double? height;
  final double iconSize;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final hue = recipe.hue.toDouble();
    final start = HSLColor.fromAHSL(1, hue, 0.72, 0.58).toColor();
    final end = HSLColor.fromAHSL(1, (hue + 18) % 360, 0.68, 0.36).toColor();

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [start, end],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -8,
            bottom: -12,
            child: Icon(recipe.icon, size: 92, color: Colors.white24),
          ),
          Center(
            child: Icon(recipe.icon, size: iconSize, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
