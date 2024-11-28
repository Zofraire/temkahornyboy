import 'package:flame/components.dart';

class Zombie extends SpriteComponent with HasGameRef {
  Zombie({required Vector2 position}) : super(size: Vector2(50, 50), position: position);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('zombie.png'); // Ensure you have this asset
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= 20 * dt; // Zombie moves left over time
  }
}
