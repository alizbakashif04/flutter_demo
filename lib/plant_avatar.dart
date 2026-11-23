import 'package:flutter/material.dart';
import 'package:flutter_go_router/plant.dart';

/// The "plant picture": a gradient tile with the plant emoji.
/// This is the widget wrapped in a [Hero] on the list card and detail page.
class PlantAvatar extends StatelessWidget {
  const PlantAvatar({
    super.key,
    required this.plant,
    this.borderRadius = 20,
    this.emojiSize = 96,
  });

  final Plant plant;
  final double borderRadius;
  final double emojiSize;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.lerp(plant.color, Colors.white, 0.2)!,
            Color.lerp(plant.color, Colors.black, 0.3)!,
          ],
        ),
      ),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              plant.emoji,
              // decoration: none avoids the yellow underline in Hero overlay.
              style: TextStyle(
                fontSize: emojiSize,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
