import 'package:flutter/material.dart';

enum SunlightLevel {
  low('Low light', Icons.wb_twilight),
  medium('Indirect light', Icons.wb_cloudy_outlined),
  bright('Bright light', Icons.wb_sunny_outlined),
  direct('Full sun', Icons.wb_sunny);

  const SunlightLevel(this.label, this.icon);

  final String label;
  final IconData icon;
}

class Plant {
  Plant({
    required this.id,
    required this.name,
    required this.scientificName,
    required this.emoji,
    required this.color,
    required this.description,
    required this.wateringIntervalDays,
    required this.sunlight,
    required this.temperature,
    required this.humidity,
    required this.careTips,
    required this.lastWatered,
  });

  final String id;
  final String name;
  final String scientificName;

  /// Used as the plant "picture". Replace with an image asset/URL if you like.
  final String emoji;
  final Color color;
  final String description;
  final int wateringIntervalDays;
  final SunlightLevel sunlight;
  final String temperature;
  final String humidity;
  final List<String> careTips;
  DateTime lastWatered;

  /// Unique Hero tag shared by the list card and the detail page.
  String get heroTag => 'plant-image-$id';

  DateTime get nextWatering {
    final last = DateUtils.dateOnly(lastWatered);
    return DateTime(last.year, last.month, last.day + wateringIntervalDays);
  }

  /// Negative = overdue, 0 = today, positive = days remaining.
  int get daysUntilWatering {
    final today = DateUtils.dateOnly(DateTime.now());
    return nextWatering.difference(today).inDays;
  }

  bool get needsWater => daysUntilWatering <= 0;

  /// 0.0 right after watering, 1.0 when the plant is due.
  double get wateringProgress {
    final elapsed = wateringIntervalDays - daysUntilWatering;
    return (elapsed / wateringIntervalDays).clamp(0.0, 1.0).toDouble();
  }

  String get wateringStatus {
    final days = daysUntilWatering;
    if (days < 0) {
      final overdue = -days;
      return 'Overdue by $overdue ${overdue == 1 ? 'day' : 'days'}';
    }
    if (days == 0) return 'Water today';
    if (days == 1) return 'Water tomorrow';
    return 'Water in $days days';
  }

  Color get statusColor {
    final days = daysUntilWatering;
    if (days < 0) return Colors.red.shade700;
    if (days == 0) return Colors.orange.shade800;
    return Colors.green.shade700;
  }
}
