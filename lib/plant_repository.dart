import 'package:flutter/material.dart';
import 'package:flutter_go_router/plant.dart';

/// Simple in-memory data source. Replace it with an API or a database later.
class PlantRepository extends ChangeNotifier {
  PlantRepository._();

  static final PlantRepository instance = PlantRepository._();

  static DateTime _daysAgo(int days) =>
      DateTime.now().subtract(Duration(days: days));

  final List<Plant> _plants = [
    Plant(
      id: 'aloe-vera',
      name: 'Aloe Vera',
      scientificName: 'Aloe barbadensis miller',
      emoji: '🪴',
      color: const Color(0xFF2E7D32),
      description:
          'A hardy succulent whose gel soothes sunburn and minor cuts. It '
          'stores water in its thick leaves, so it prefers to dry out '
          'between waterings.',
      wateringIntervalDays: 14,
      sunlight: SunlightLevel.bright,
      temperature: '15–30 °C',
      humidity: 'Low (30–40%)',
      careTips: const [
        'Let the soil dry out completely before watering again.',
        'Use a pot with drainage holes and a cactus mix.',
        'Place it near a sunny window with a few hours of direct light.',
        'Water even less in winter.',
      ],
      lastWatered: _daysAgo(10),
    ),
    Plant(
      id: 'monstera',
      name: 'Monstera',
      scientificName: 'Monstera deliciosa',
      emoji: '🌿',
      color: const Color(0xFF388E3C),
      description:
          'A popular tropical climber with big, split leaves. It grows fast '
          'in warm, humid rooms and loves something to climb on.',
      wateringIntervalDays: 7,
      sunlight: SunlightLevel.medium,
      temperature: '18–27 °C',
      humidity: 'High (60%+)',
      careTips: const [
        'Water when the top 2–3 cm of soil feels dry.',
        'Wipe the leaves with a damp cloth to keep them shiny.',
        'Give it a moss pole or stake to climb.',
        'Rotate the pot every few weeks for even growth.',
      ],
      lastWatered: _daysAgo(8),
    ),
    Plant(
      id: 'snake-plant',
      name: 'Snake Plant',
      scientificName: 'Dracaena trifasciata',
      emoji: '🌱',
      color: const Color(0xFF00796B),
      description:
          'Nearly indestructible. The snake plant tolerates low light and '
          'irregular watering, which makes it perfect for beginners.',
      wateringIntervalDays: 14,
      sunlight: SunlightLevel.low,
      temperature: '15–29 °C',
      humidity: 'Low to average',
      careTips: const [
        'Overwatering is the biggest danger because it causes root rot.',
        'It copes well with low light, but grows faster in brighter spots.',
        'Wipe dust off the leaves once a month.',
        'Keep it away from cold drafts.',
      ],
      lastWatered: _daysAgo(3),
    ),
    Plant(
      id: 'cactus',
      name: 'Cactus',
      scientificName: 'Cactaceae',
      emoji: '🌵',
      color: const Color(0xFF558B2F),
      description:
          'A desert plant that stores water in its stem. Give it lots of sun '
          'and very little water.',
      wateringIntervalDays: 21,
      sunlight: SunlightLevel.direct,
      temperature: '18–35 °C',
      humidity: 'Low (10–30%)',
      careTips: const [
        'Plant it in gritty, fast-draining soil.',
        'Give it as much direct sun as you can.',
        'Water deeply but rarely, and let the soil dry out in between.',
        'Almost no water is needed in winter.',
      ],
      lastWatered: _daysAgo(21),
    ),
    Plant(
      id: 'rose',
      name: 'Rose',
      scientificName: 'Rosa',
      emoji: '🌹',
      color: const Color(0xFFC2185B),
      description:
          'A classic flowering shrub that rewards regular care with '
          'beautiful, fragrant blooms.',
      wateringIntervalDays: 3,
      sunlight: SunlightLevel.direct,
      temperature: '15–28 °C',
      humidity: 'Moderate',
      careTips: const [
        'Water at the base of the plant, not on the leaves.',
        'Give it at least 6 hours of sun every day.',
        'Remove dead flowers to encourage new blooms.',
        'Feed every few weeks during the growing season.',
      ],
      lastWatered: _daysAgo(2),
    ),
    Plant(
      id: 'money-plant',
      name: 'Money Plant',
      scientificName: 'Epipremnum aureum',
      emoji: '🍃',
      color: const Color(0xFF43A047),
      description:
          'An easy trailing vine that grows in soil or in a jar of water. '
          'Great for shelves, hanging pots and office desks.',
      wateringIntervalDays: 7,
      sunlight: SunlightLevel.medium,
      temperature: '15–30 °C',
      humidity: 'Moderate',
      careTips: const [
        'If it grows in water, change the water every week.',
        'Trim long vines to keep the plant bushy.',
        'Avoid harsh direct afternoon sun.',
        'It is toxic to pets, so keep it out of reach.',
      ],
      lastWatered: _daysAgo(4),
    ),
    Plant(
      id: 'sunflower',
      name: 'Sunflower',
      scientificName: 'Helianthus annuus',
      emoji: '🌻',
      color: const Color(0xFFEF6C00),
      description:
          'A tall, cheerful flower that follows the sun. It grows best '
          'outdoors in rich soil with plenty of light.',
      wateringIntervalDays: 3,
      sunlight: SunlightLevel.direct,
      temperature: '18–30 °C',
      humidity: 'Moderate',
      careTips: const [
        'Needs 6–8 hours of direct sunlight every day.',
        'Water deeply at the base rather than a little every day.',
        'Support tall stems with a stake.',
        'Plant in rich, well-draining soil.',
      ],
      lastWatered: _daysAgo(1),
    ),
    Plant(
      id: 'lucky-bamboo',
      name: 'Lucky Bamboo',
      scientificName: 'Dracaena sanderiana',
      emoji: '🎋',
      color: const Color(0xFF33691E),
      description:
          'A low-maintenance indoor plant that thrives in a vase of water '
          'with a few pebbles.',
      wateringIntervalDays: 7,
      sunlight: SunlightLevel.medium,
      temperature: '18–32 °C',
      humidity: 'Moderate',
      careTips: const [
        'Keep the roots covered with water at all times.',
        'Use filtered or distilled water if possible.',
        'Change the water once a week.',
        'Avoid direct sun, which can burn the leaves.',
      ],
      lastWatered: _daysAgo(7),
    ),
  ];

  List<Plant> get plants => List.unmodifiable(_plants);

  /// Number of plants that are due (or overdue) for watering.
  int get dueCount => _plants.where((plant) => plant.needsWater).length;

  Plant? byId(String id) {
    for (final plant in _plants) {
      if (plant.id == id) return plant;
    }
    return null;
  }

  void markWatered(String id) {
    final plant = byId(id);
    if (plant == null) return;
    plant.lastWatered = DateTime.now();
    notifyListeners();
  }
}
