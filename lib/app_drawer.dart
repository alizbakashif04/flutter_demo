import 'package:flutter/material.dart';
import 'package:flutter_go_router/plant_repository.dart';
import 'package:go_router/go_router.dart';

/// Navigation drawer shared by the three main screens.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, required this.currentRoute});

  /// The route of the screen that shows the drawer, e.g. '/plants'.
  final String currentRoute;

  @override
  Widget build(BuildContext context) {
    final repo = PlantRepository.instance;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const _DrawerHeader(),
          const SizedBox(height: 8),
          _DrawerItem(
            icon: Icons.local_florist_outlined,
            label: 'My Plants',
            route: '/plants',
            currentRoute: currentRoute,
          ),
          _DrawerItem(
            icon: Icons.lightbulb_outline,
            label: 'Tips',
            route: '/tips',
            currentRoute: currentRoute,
          ),
          ListenableBuilder(
            listenable: repo,
            builder: (context, _) {
              return _DrawerItem(
                icon: Icons.notifications_none,
                label: 'Reminders',
                route: '/reminders',
                currentRoute: currentRoute,
                badgeCount: repo.dueCount,
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
            child: Divider(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ListTile(
              shape: const StadiumBorder(),
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'Plant Care',
                  applicationVersion: '1.0.0',
                  applicationIcon: const Text(
                    '🌿',
                    style: TextStyle(fontSize: 36),
                  ),
                  children: const [
                    Text(
                      'Track your plants, learn how to care for them and '
                      'never forget to water them again.',
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        20,
        MediaQuery.of(context).padding.top + 24,
        20,
        24,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF66BB6A), Color(0xFF1B5E20)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('🌿', style: TextStyle(fontSize: 44)),
          const SizedBox(height: 12),
          Text(
            'Plant Care',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Keep your plants happy',
            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.route,
    required this.currentRoute,
    this.badgeCount = 0,
  });

  final IconData icon;
  final String label;
  final String route;
  final String currentRoute;
  final int badgeCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selected = currentRoute == route;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: ListTile(
        shape: const StadiumBorder(),
        selected: selected,
        selectedTileColor: theme.colorScheme.primaryContainer,
        leading: Icon(icon),
        title: Text(label),
        trailing: badgeCount > 0
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red.shade600,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$badgeCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : null,
        onTap: () {
          final router = GoRouter.of(context);
          Navigator.of(context).pop(); // close the drawer
          if (!selected) router.go(route);
        },
      ),
    );
  }
}
