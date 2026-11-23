import 'package:flutter/material.dart';
import 'package:flutter_go_router/app_drawer.dart';
import 'package:flutter_go_router/date_format.dart';
import 'package:flutter_go_router/plant.dart';
import 'package:flutter_go_router/plant_avatar.dart';
import 'package:flutter_go_router/plant_repository.dart';
import 'package:go_router/go_router.dart';

class RemindersScreen extends StatelessWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = PlantRepository.instance;

    return Scaffold(
      appBar: AppBar(title: const Text('Reminders')),
      drawer: const AppDrawer(currentRoute: '/reminders'),
      body: ListenableBuilder(
        listenable: repo,
        builder: (context, _) {
          final sorted = [
            ...repo.plants,
          ]..sort((a, b) => a.daysUntilWatering.compareTo(b.daysUntilWatering));
          final due = sorted.where((plant) => plant.needsWater).toList();
          final upcoming = sorted.where((plant) => !plant.needsWater).toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _SectionHeader(title: 'Needs water now', count: due.length),
              if (due.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: Text('Nothing to water right now 🎉')),
                ),
              for (final plant in due) _ReminderTile(plant: plant),
              const SizedBox(height: 16),
              _SectionHeader(title: 'Upcoming', count: upcoming.length),
              for (final plant in upcoming) _ReminderTile(plant: plant),
            ],
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.count});

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        '$title ($count)',
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _ReminderTile extends StatelessWidget {
  const _ReminderTile({required this.plant});

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: () => context.push('/plant/${plant.id}'),
        leading: SizedBox(
          width: 48,
          height: 48,
          child: PlantAvatar(plant: plant, borderRadius: 12),
        ),
        title: Text(
          plant.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          plant.wateringStatus,
          style: TextStyle(
            color: plant.statusColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: plant.needsWater
            ? FilledButton.tonal(
                onPressed: () {
                  PlantRepository.instance.markWatered(plant.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${plant.name} watered 💧')),
                  );
                },
                child: const Text('Water'),
              )
            : Text(
                formatDate(plant.nextWatering),
                style: theme.textTheme.bodySmall,
              ),
      ),
    );
  }
}
