// Tests « golden » utilisés pour générer les captures d'écran du README.
// Génération : flutter test test/screenshots_golden_test.dart --update-goldens
//
// Les images produites sont ensuite copiées dans /screenshots.
@Tags(['golden'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saveurs_afrique/app.dart';

import 'helpers/test_fonts.dart';

void main() {
  setUpAll(loadTestFonts);

  Future<void> startApp(WidgetTester tester, Size size) async {
    // Par défaut les tests remplacent les ombres par des rectangles noirs
    // pleins ; on réactive le rendu réel des ombres pour des captures
    // fidèles à l'application (réinitialisé après chaque golden, cf. [golden]).
    debugDisableShadows = false;
    setSurfaceSize(tester, size);
    await tester.pumpWidget(const SaveursApp());
    await tester.pumpAndSettle();
  }

  Future<void> golden(WidgetTester tester, String name) async {
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('goldens/$name.png'),
    );
    // Rétablit la valeur attendue par le binding avant sa vérif de fin
    // de test (sinon : « painting debug variable was changed »).
    debugDisableShadows = true;
  }

  Future<void> tapTab(WidgetTester tester, String label) async {
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text(label),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('01 - Accueil (mobile, clair)', (tester) async {
    await startApp(tester, kPhoneSize);
    await golden(tester, '01_accueil_mobile_clair');
  });

  testWidgets('02 - Liste avec recherche (mobile, clair)', (tester) async {
    await startApp(tester, kPhoneSize);
    await tapTab(tester, 'Recettes');
    await tester.enterText(find.byType(TextField), 'riz');
    await tester.pump();
    await golden(tester, '02_recherche_mobile_clair');
  });

  testWidgets('03 - Détail d\u2019une recette (mobile, clair)', (tester) async {
    await startApp(tester, kPhoneSize);
    await tapTab(tester, 'Recettes');
    await tester.tap(find.byType(Card).first);
    await tester.pumpAndSettle();
    await golden(tester, '03_detail_mobile_clair');
  });

  testWidgets('04 - Favoris (mobile, sombre)', (tester) async {
    await startApp(tester, kPhoneSize);
    await tapTab(tester, 'Réglages');
    await tester.tap(find.text('Sombre'));
    await tester.pumpAndSettle();
    await tapTab(tester, 'Favoris');
    await golden(tester, '04_favoris_mobile_sombre');
  });

  testWidgets('05 - Formulaire d\u2019ajout (mobile, clair)', (tester) async {
    await startApp(tester, kPhoneSize);
    await tapTab(tester, 'Recettes');
    await tester.tap(find.widgetWithText(FloatingActionButton, 'Ajouter'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Nom du plat *'),
      'Akpan',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Pays / région d\u2019origine *'),
      'Bénin',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Ingrédients * (un par ligne)'),
      'Maïs frais fermenté\nLait concentré\nSucre vanillé\nNoix de muscade',
    );
    await tester.enterText(
      find.widgetWithText(
        TextFormField,
        'Étapes de préparation * (une par ligne)',
      ),
      'Égoutter la pâte de maïs fermenté\nMixer et sucrer\nServir bien frais',
    );
    await tester.pump();
    await golden(tester, '05_formulaire_mobile_clair');
  });

  testWidgets('06 - Recettes en grille (tablette, clair)', (tester) async {
    await startApp(tester, kTabletLandscapeSize);
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationRail),
        matching: find.text('Recettes'),
      ),
    );
    await tester.pumpAndSettle();
    await golden(tester, '06_recettes_tablette_clair');
  });

  testWidgets('07 - Accueil (tablette, sombre)', (tester) async {
    await startApp(tester, kTabletLandscapeSize);
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationRail),
        matching: find.text('Réglages'),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sombre'));
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationRail),
        matching: find.text('Accueil'),
      ),
    );
    await tester.pumpAndSettle();
    // Faire apparaître la liste horizontale des populaires.
    await golden(tester, '07_accueil_tablette_sombre');
  });
}
