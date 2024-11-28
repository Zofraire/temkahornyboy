import 'package:flame/components.dart';

class Plant extends SpriteComponent with HasGameRef {
  Plant({required Vector2 position}) : super(size: Vector2(50, 50), position: position);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('plant.png');
  }
}
