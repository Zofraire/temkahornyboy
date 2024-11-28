import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'plant.dart';
import 'zombie.dart';

class GameWorld extends StatelessWidget {
  const GameWorld({super.key});

  @override
  Widget build(BuildContext context) {
    final game = PlantsVsZombiesGame();

    return Scaffold(
      body: GameWidget(
        game: game,
      ),
    );
  }
}

class PlantsVsZombiesGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    // Add plant and zombie entities to the game world
    add(Plant(position: Vector2(100, 200)));
    add(Zombie(position: Vector2(400, 200)));
  }
}
