import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Charge les polices Roboto et MaterialIcons depuis le SDK Flutter pour
/// que les captures golden affichent du vrai texte et de vraies icônes
/// (au lieu de la police de test « Ahem »).
Future<void> loadTestFonts() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Détecte la racine du SDK Flutter : variable FLUTTER_ROOT sinon on
  // remonte depuis l'exécutable jusqu'à trouver les polices Material.
  var flutterRoot = Platform.environment['FLUTTER_ROOT'];
  if (flutterRoot == null ||
      !Directory('$flutterRoot/bin/cache/artifacts/material_fonts')
          .existsSync()) {
    var dir = File(Platform.resolvedExecutable).parent;
    for (var i = 0; i < 8; i++) {
      if (Directory('${dir.path}/bin/cache/artifacts/material_fonts')
          .existsSync()) {
        flutterRoot = dir.path;
        break;
      }
      dir = dir.parent;
    }
  }
  final fontDir = '$flutterRoot/bin/cache/artifacts/material_fonts';

  Future<void> load(String family, String file) async {
    final bytes = File('$fontDir/$file').readAsBytesSync();
    final loader = FontLoader(family);
    loader.addFont(
      Future.value(bytes.buffer.asByteData(bytes.offsetInBytes, bytes.length)),
    );
    await loader.load();
  }

  await Future.wait([
    load('Roboto', 'Roboto-Regular.ttf'),
    load('Roboto', 'Roboto-Medium.ttf'),
    load('Roboto', 'Roboto-Bold.ttf'),
    load('Roboto', 'Roboto-Light.ttf'),
    load('MaterialIcons', 'MaterialIcons-Regular.otf'),
  ]);
}

/// Définit la taille d'écran simulée (en pixels logiques) pour un test.
void setSurfaceSize(WidgetTester tester, Size logical, {double dpr = 2}) {
  tester.view.physicalSize = logical * dpr;
  tester.view.devicePixelRatio = dpr;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

const Size kPhoneSize = Size(390, 844);
const Size kTabletLandscapeSize = Size(1080, 720);
