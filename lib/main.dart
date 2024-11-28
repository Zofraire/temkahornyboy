import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const GameWorld());
}

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

class PlantsVsZombiesGame extends FlameGame with HasCollisionDetection {
  @override
  Future<void> onLoad() async {
    // Add plant and zombie entities to the game world
    add(Plant(position: Vector2(100, 200)));
    add(Zombie(position: Vector2(400, 200)));
  }
}

// Plant Class
class Plant extends SpriteComponent with HasGameRef, CollisionCallbacks {
  late TimerComponent shootTimer;

  Plant({required Vector2 position})
      : super(
          size: Vector2(50, 50),
          position: position,
        );

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('plant.png'); // Ensure this asset exists
    add(CircleHitbox()); // Add hitbox for collision
    _startShooting();
  }

  void _startShooting() {
    shootTimer = TimerComponent(
      period: 1, // Shoot every 1 second
      repeat: true,
      onTick: () {
        final bullet = Bullet(position: position + Vector2(size.x, size.y / 2));
        gameRef.add(bullet);
      },
    );
    add(shootTimer);
  }
}

// Zombie Class
class Zombie extends SpriteComponent with HasGameRef, CollisionCallbacks {
  double health = 3;

  Zombie({required Vector2 position})
      : super(
          size: Vector2(50, 50),
          position: position,
        );

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('zombie.png'); // Ensure this asset exists
    add(CircleHitbox()); // Add hitbox for collision
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Bullet) {
      health -= 1;
      other.removeFromParent(); // Remove the bullet on collision
      if (health <= 0) {
        removeFromParent(); // Remove the zombie if health is zero
      }
    }
    super.onCollision(intersectionPoints, other);
  }
}

// Bullet Class
class Bullet extends SpriteComponent with HasGameRef, CollisionCallbacks {
  Bullet({required Vector2 position})
      : super(
          size: Vector2(20, 10),
          position: position,
        );

  final double speed = 200;

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('bullet.png'); // Ensure this asset exists
    add(RectangleHitbox()); // Add hitbox for collision
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x += speed * dt;

    // Remove the bullet if it goes off-screen
    if (position.x > gameRef.size.x) {
      removeFromParent();
    }
  }
}
