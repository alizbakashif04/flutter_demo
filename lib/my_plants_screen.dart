import 'package:flutter/material.dart';
import 'package:flutter_go_router/app_drawer.dart';
import 'package:flutter_go_router/plant_card.dart';
import 'package:flutter_go_router/plant_repository.dart';
import 'package:go_router/go_router.dart';

class MyPlantsScreen extends StatelessWidget {
  const MyPlantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = PlantRepository.instance;

    return Scaffold(
      appBar: AppBar(title: const Text('My Plants')),
      drawer: const AppDrawer(currentRoute: '/plants'),
      body: ListenableBuilder(
        listenable: repo,
        builder: (context, _) {
          final plants = repo.plants;

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _SummaryBanner(
                  dueCount: repo.dueCount,
                  total: plants.length,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 240,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 0.82,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => PlantCard(plant: plants[index]),
                    childCount: plants.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SummaryBanner extends StatelessWidget {
  const _SummaryBanner({required this.dueCount, required this.total});

  final int dueCount;
  final int total;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final message = dueCount == 0
        ? 'All $total plants are happy and watered 🌿'
        : '$dueCount of $total plants '
              '${dueCount == 1 ? 'needs' : 'need'} water';

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Material(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => context.go('/reminders'),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  dueCount == 0 ? Icons.check_circle : Icons.water_drop,
                  color: colors.onPrimaryContainer,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: colors.onPrimaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(Icons.chevron_right, color: colors.onPrimaryContainer),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
