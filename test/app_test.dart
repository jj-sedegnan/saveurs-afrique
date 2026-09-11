import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saveurs_afrique/app.dart';
import 'package:saveurs_afrique/data/recipe_repository.dart';
import 'package:saveurs_afrique/models/recipe.dart';
import 'package:saveurs_afrique/state/app_state.dart';

import 'helpers/test_fonts.dart';

void main() {
  group('RecipeStore', () {
    late RecipeStore store;

    setUp(() {
      store = RecipeStore(InMemoryRecipeRepository());
    });

    test('charge les recettes de départ', () {
      expect(store.all.length, greaterThanOrEqualTo(10));
      expect(store.findById('yassa')?.name, 'Poulet Yassa');
    });

    test('recherche par texte sur le nom, le pays et les ingrédients', () {
      expect(store.search(query: 'riz'), isNotEmpty);
      expect(
        store.search(query: 'SÉNÉGAL'.toLowerCase()),
        contains(store.findById('yassa')),
      );
      expect(store.search(query: 'inexistant-xyz'), isEmpty);
    });

    test('filtre par catégorie', () {
      final boissons = store.search(category: 'Boissons');
      expect(boissons, isNotEmpty);
      expect(boissons.every((r) => r.category == 'Boissons'), isTrue);
    });

    test('ajoute / retire des favoris', () {
      final initial = store.favoriteCount;
      store.toggleFavorite('jollof');
      expect(store.isFavorite('jollof'), isTrue);
      expect(store.favoriteCount, initial + 1);
      store.toggleFavorite('jollof');
      expect(store.isFavorite('jollof'), isFalse);
    });

    test('ajoute une recette via le formulaire (données)', () {
      final before = store.all.length;
      final created = store.addRecipe(
        name: 'Akpan',
        country: 'Bénin',
        category: 'Desserts',
        description: 'Crème de maïs fermenté',
        minutes: 25,
        servings: 4,
        difficulty: Difficulty.easy,
        ingredients: ['Maïs', 'Lait', 'Sucre'],
        steps: ['Laisser fermenter', 'Servir frais'],
      );
      expect(store.all.length, before + 1);
      expect(store.findById(created.id), isNotNull);
      expect(created.durationLabel, '25 min');
    });

    test('étiquette de durée pour plus d\u2019une heure', () {
      const r = Recipe(
        id: 'x',
        name: 'x',
        country: 'x',
        category: 'x',
        description: 'x',
        minutes: 75,
        servings: 2,
        difficulty: Difficulty.easy,
        ingredients: [],
        steps: [],
        icon: Icons.check,
        hue: 0,
      );
      expect(r.durationLabel, '1 h 15');
    });
  });

  group('SaveursApp (widgets)', () {
    testWidgets('navigation Accueil -> Recettes -> détail', (tester) async {
      setSurfaceSize(tester, kPhoneSize, dpr: 1);
      await tester.pumpWidget(const SaveursApp());
      await tester.pump();

      // Accueil : titre et champ de recherche.
      expect(find.text('Saveurs d\u2019Afrique'), findsOneWidget);
      expect(find.text('Explorer par catégorie'), findsOneWidget);

      // Aller sur l'onglet Recettes.
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text('Recettes'),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(TextField), findsOneWidget);
      expect(find.textContaining('recette'), findsWidgets);

      // Ouvrir la première carte de recette.
      await tester.tap(find.byType(Card).first);
      await tester.pumpAndSettle();
      expect(find.text('Ingrédients (9)'), findsOneWidget);
      expect(find.textContaining('étapes'), findsOneWidget);
    });

    testWidgets('recherche filtre les résultats', (tester) async {
      setSurfaceSize(tester, kPhoneSize, dpr: 1);
      await tester.pumpWidget(const SaveursApp());
      await tester.pumpAndSettle();

      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text('Recettes'),
        ),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'bissap');
      await tester.pump();

      expect(find.text('Jus de bissap'), findsWidgets);
      expect(find.text('Poulet Yassa'), findsNothing);

      // Annuler la recherche.
      await tester.tap(find.byIcon(Icons.clear));
      await tester.pump();
      expect(find.text('Poulet Yassa'), findsWidgets);
    });

    testWidgets('bascule clair / sombre dans les réglages', (tester) async {
      setSurfaceSize(tester, kPhoneSize, dpr: 1);
      await tester.pumpWidget(const SaveursApp());
      await tester.pumpAndSettle();

      MaterialApp app() => tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(app().themeMode, ThemeMode.system);

      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text('Réglages'),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Sombre'));
      await tester.pumpAndSettle();
      expect(app().themeMode, ThemeMode.dark);
      expect(
        Theme.of(tester.element(find.byType(Scaffold).first)).brightness,
        Brightness.dark,
      );
    });
  });
}
