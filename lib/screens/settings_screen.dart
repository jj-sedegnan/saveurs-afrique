import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../state/app_state.dart';

/// Écran des réglages : gestion du thème clair / sombre / système.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.themeController;
    final store = context.recipeStore;

    return Scaffold(
      appBar: AppBar(title: const Text('Réglages')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Apparence',
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Card(
                child: RadioGroup<ThemeMode>(
                  groupValue: theme.mode,
                  onChanged: (m) => theme.mode = m!,
                  child: const Column(
                    children: [
                      RadioListTile<ThemeMode>(
                        value: ThemeMode.system,
                        title: Text('Système'),
                        subtitle: Text("Suit le réglage de l'appareil"),
                        secondary: Icon(Icons.smartphone),
                      ),
                      Divider(height: 1, indent: 16, endIndent: 16),
                      RadioListTile<ThemeMode>(
                        value: ThemeMode.light,
                        title: Text('Clair'),
                        subtitle: Text('Interface lumineuse'),
                        secondary: Icon(Icons.wb_sunny_outlined),
                      ),
                      Divider(height: 1, indent: 16, endIndent: 16),
                      RadioListTile<ThemeMode>(
                        value: ThemeMode.dark,
                        title: Text('Sombre'),
                        subtitle: Text('Interface assombrie'),
                        secondary: Icon(Icons.dark_mode_outlined),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Données',
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.restaurant_menu),
                      title: const Text('Recettes disponibles'),
                      trailing: Text('${store.all.length}'),
                    ),
                    const Divider(height: 1, indent: 16, endIndent: 16),
                    ListTile(
                      leading: const Icon(Icons.favorite),
                      title: const Text('Recettes favorites'),
                      trailing: Text('${store.favoriteCount}'),
                    ),
                    const Divider(height: 1, indent: 16, endIndent: 16),
                    ListTile(
                      leading: const Icon(Icons.add),
                      title: const Text('Ajouter ma recette'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.pushNamed('ajouter'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'À propos',
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Saveurs d\u2019Afrique',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Application de démonstration construite avec Flutter, '
                        'GoRouter (routes nommées), Material 3 et une '
                        'navigation responsive mobile / tablette.',
                        style: TextStyle(height: 1.45),
                      ),
                      SizedBox(height: 8),
                      Text('Version 1.0.0'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
