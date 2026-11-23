import 'package:flutter/material.dart';
import 'package:flutter_go_router/my_plants_screen.dart';
import 'package:flutter_go_router/plant_detail_screen.dart';
import 'package:flutter_go_router/reminders_screen.dart';
import 'package:flutter_go_router/tips_screen.dart';
import 'package:go_router/go_router.dart';

/// All routes live on ONE navigator (no ShellRoute). Hero animations only
/// fly between routes that belong to the same Navigator.
///
/// Drawer destinations use `context.go(...)`, while the plant detail page
/// uses `context.push(...)` so the back button returns to the previous screen.
final GoRouter appRouter = GoRouter(
  initialLocation: '/plants',
  routes: [
    GoRoute(path: '/', redirect: (context, state) => '/plants'),
    GoRoute(
      path: '/plants',
      name: 'plants',
      pageBuilder: (context, state) =>
          const NoTransitionPage<void>(child: MyPlantsScreen()),
    ),
    GoRoute(
      path: '/tips',
      name: 'tips',
      pageBuilder: (context, state) =>
          const NoTransitionPage<void>(child: TipsScreen()),
    ),
    GoRoute(
      path: '/reminders',
      name: 'reminders',
      pageBuilder: (context, state) =>
          const NoTransitionPage<void>(child: RemindersScreen()),
    ),
    GoRoute(
      path: '/plant/:id',
      name: 'plantDetail',
      pageBuilder: (context, state) {
        final id = state.pathParameters['id']!;
        return CustomTransitionPage<void>(
          key: state.pageKey,
          transitionDuration: const Duration(milliseconds: 500),
          reverseTransitionDuration: const Duration(milliseconds: 400),
          child: PlantDetailScreen(plantId: id),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              ),
              child: child,
            );
          },
        );
      },
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Page not found')),
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Sorry, this page does not exist.'),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => context.go('/plants'),
            child: const Text('Back to My Plants'),
          ),
        ],
      ),
    ),
  ),
);
