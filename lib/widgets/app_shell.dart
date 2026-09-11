import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../state/app_state.dart';

/// Seuil de largeur (en px) au-delà duquel on bascule sur une tablette.
const double kTabletBreakpoint = 700;

/// Coquille de navigation responsive :
/// - mobile : [NavigationBar] en bas ;
/// - tablette / desktop : [NavigationRail] à gauche (étendue en très large).
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= kTabletBreakpoint) {
          final extended = constraints.maxWidth >= 920;
          return Scaffold(
            body: Row(
              children: [
                _SideRail(
                  extended: extended,
                  currentIndex: navigationShell.currentIndex,
                  onSelect: _goBranch,
                ),
                const VerticalDivider(width: 1),
                Expanded(child: navigationShell),
              ],
            ),
          );
        }
        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: NavigationBar(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: _goBranch,
            destinations: _destinations(context),
          ),
        );
      },
    );
  }

  List<NavigationDestination> _destinations(BuildContext context) {
    final favCount = context.recipeStore.favoriteCount;
    return [
      const NavigationDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home),
        label: 'Accueil',
      ),
      const NavigationDestination(
        icon: Icon(Icons.restaurant_menu),
        selectedIcon: Icon(Icons.restaurant),
        label: 'Recettes',
      ),
      NavigationDestination(
        icon: Badge(
          isLabelVisible: favCount > 0,
          label: Text('$favCount'),
          child: const Icon(Icons.favorite_outline),
        ),
        selectedIcon: Badge(
          isLabelVisible: favCount > 0,
          label: Text('$favCount'),
          child: const Icon(Icons.favorite),
        ),
        label: 'Favoris',
      ),
      const NavigationDestination(
        icon: Icon(Icons.settings_outlined),
        selectedIcon: Icon(Icons.settings),
        label: 'Réglages',
      ),
    ];
  }
}

class _SideRail extends StatelessWidget {
  const _SideRail({
    required this.extended,
    required this.currentIndex,
    required this.onSelect,
  });

  final bool extended;
  final int currentIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final favCount = context.recipeStore.favoriteCount;

    final destinations = [
      const NavigationRailDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home),
        label: Text('Accueil'),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.restaurant_menu),
        selectedIcon: Icon(Icons.restaurant),
        label: Text('Recettes'),
      ),
      NavigationRailDestination(
        icon: Badge(
          isLabelVisible: favCount > 0,
          label: Text('$favCount'),
          child: const Icon(Icons.favorite_outline),
        ),
        selectedIcon: Badge(
          isLabelVisible: favCount > 0,
          label: Text('$favCount'),
          child: const Icon(Icons.favorite),
        ),
        label: const Text('Favoris'),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.settings_outlined),
        selectedIcon: Icon(Icons.settings),
        label: Text('Réglages'),
      ),
    ];

    return NavigationRail(
      extended: extended,
      minExtendedWidth: 220,
      labelType: extended ? null : NavigationRailLabelType.all,
      selectedIndex: currentIndex,
      onDestinationSelected: onSelect,
      leading: Padding(
        padding: EdgeInsets.symmetric(vertical: extended ? 12 : 8),
        child: FloatingActionButton(
          heroTag: 'add-recipe-rail',
          tooltip: 'Ajouter une recette',
          onPressed: () => context.pushNamed('ajouter'),
          child: const Icon(Icons.add),
        ),
      ),
      destinations: destinations,
    );
  }
}
