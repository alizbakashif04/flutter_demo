import 'package:flutter/material.dart';
import 'package:flutter_go_router/date_format.dart';
import 'package:flutter_go_router/plant.dart';
import 'package:flutter_go_router/plant_avatar.dart';
import 'package:flutter_go_router/plant_repository.dart';

class PlantDetailScreen extends StatelessWidget {
  const PlantDetailScreen({super.key, required this.plantId});

  final String plantId;

  @override
  Widget build(BuildContext context) {
    final repo = PlantRepository.instance;

    return ListenableBuilder(
      listenable: repo,
      builder: (context, _) {
        final plant = repo.byId(plantId);

        if (plant == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('Plant not found')),
          );
        }

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 320,
                backgroundColor: plant.color,
                foregroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(plant.name),
                  background: Hero(
                    // Same tag as the card on the My Plants screen.
                    tag: plant.heroTag,
                    child: PlantAvatar(
                      plant: plant,
                      borderRadius: 0,
                      emojiSize: 140,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: _DetailBody(plant: plant),
                ),
              ),
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: FilledButton.icon(
                onPressed: () {
                  repo.markWatered(plant.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${plant.name} marked as watered 💧'),
                    ),
                  );
                },
                icon: const Icon(Icons.water_drop),
                label: const Text('Mark as watered'),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({required this.plant});

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sectionStyle = theme.textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.bold,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          plant.scientificName,
          style: theme.textTheme.titleMedium?.copyWith(
            fontStyle: FontStyle.italic,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 12),
        Text(plant.description, style: theme.textTheme.bodyLarge),
        const SizedBox(height: 24),
        Text('Quick facts', style: sectionStyle),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _InfoTile(
                icon: Icons.water_drop_outlined,
                label: 'Watering',
                value: 'Every ${plant.wateringIntervalDays} days',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _InfoTile(
                icon: plant.sunlight.icon,
                label: 'Sunlight',
                value: plant.sunlight.label,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _InfoTile(
                icon: Icons.thermostat,
                label: 'Temperature',
                value: plant.temperature,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _InfoTile(
                icon: Icons.opacity,
                label: 'Humidity',
                value: plant.humidity,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text('Watering schedule', style: sectionStyle),
        const SizedBox(height: 12),
        _ScheduleCard(plant: plant),
        const SizedBox(height: 24),
        Text('Care tips', style: sectionStyle),
        const SizedBox(height: 12),
        Card(
          child: Column(
            children: [
              for (final tip in plant.careTips)
                ListTile(
                  leading: Icon(
                    Icons.check_circle_outline,
                    color: theme.colorScheme.primary,
                  ),
                  title: Text(tip),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: theme.colorScheme.primary),
            const SizedBox(height: 10),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScheduleCard extends StatelessWidget {
  const _ScheduleCard({required this.plant});

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.water_drop, color: plant.statusColor),
                const SizedBox(width: 8),
                Text(
                  plant.wateringStatus,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: plant.statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: plant.wateringProgress,
                minHeight: 8,
                color: plant.statusColor,
              ),
            ),
            const SizedBox(height: 12),
            _ScheduleRow(
              label: 'Last watered',
              value: formatDate(plant.lastWatered),
            ),
            _ScheduleRow(
              label: 'Next watering',
              value: formatDate(plant.nextWatering),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScheduleRow extends StatelessWidget {
  const _ScheduleRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
