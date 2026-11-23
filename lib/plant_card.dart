import 'package:flutter/material.dart';
import 'package:flutter_go_router/plant.dart';
import 'package:go_router/go_router.dart';
import 'plant_avatar.dart';

class PlantCard extends StatelessWidget {
  const PlantCard({super.key, required this.plant});

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push('/plant/${plant.id}'),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                // The same tag is used on the detail page.
                child: Hero(
                  tag: plant.heroTag,
                  child: PlantAvatar(plant: plant),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                plant.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.water_drop, size: 14, color: plant.statusColor),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      plant.wateringStatus,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: plant.statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
