import 'package:flutter/material.dart';
import 'package:flutter_go_router/app_drawer.dart';

class _Tip {
  const _Tip(this.icon, this.title, this.body);

  final IconData icon;
  final String title;
  final String body;
}

const List<_Tip> _tips = [
  _Tip(
    Icons.water_drop_outlined,
    'Water the right way',
    'Check the soil with your finger. If the top 2–3 cm feels dry, it is '
        'time to water. Water slowly until it drains from the bottom, then '
        'empty the saucer.',
  ),
  _Tip(
    Icons.wb_sunny_outlined,
    'Give enough light',
    'Most houseplants like bright, indirect light. Leaves that stretch '
        'toward the window or turn pale usually mean the plant needs more '
        'light.',
  ),
  _Tip(
    Icons.terrain,
    'Choose the right soil',
    'Use a well-draining mix. Succulents need gritty soil, while leafy '
        'plants like a richer mix with compost or coco peat.',
  ),
  _Tip(
    Icons.eco_outlined,
    'Feed in the growing season',
    'Use a balanced fertilizer every 4–6 weeks in spring and summer. Skip '
        'feeding in winter when growth slows down.',
  ),
  _Tip(
    Icons.cloud_outlined,
    'Watch the humidity',
    'Tropical plants love humid air. Group plants together, use a pebble '
        'tray, or mist lightly in the morning.',
  ),
  _Tip(
    Icons.inventory_2_outlined,
    'Repot when roots are crowded',
    'If roots circle the pot or poke out of the drainage holes, move the '
        'plant to a pot one size bigger, ideally in spring.',
  ),
  _Tip(
    Icons.bug_report_outlined,
    'Spot pests early',
    'Check under the leaves every week. Wipe off small pests with a damp '
        'cloth or spray a mild neem oil solution.',
  ),
  _Tip(
    Icons.ac_unit,
    'Adjust with the seasons',
    'Plants grow slower in winter and need less water and no fertilizer. '
        'Keep them away from cold drafts and heaters.',
  ),
];

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Tips')),
      drawer: const AppDrawer(currentRoute: '/tips'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _tips.length,
        itemBuilder: (context, index) {
          final tip = _tips[index];

          return Card(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.only(bottom: 12),
            child: ExpansionTile(
              shape: const Border(),
              collapsedShape: const Border(),
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.primaryContainer,
                child: Icon(
                  tip.icon,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
              title: Text(
                tip.title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(tip.body, style: theme.textTheme.bodyMedium)],
            ),
          );
        },
      ),
    );
  }
}
