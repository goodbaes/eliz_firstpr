import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import '../../../../../data/storage/storage.dart';
import '../../thrill_run_game.dart';
import '../logical_size_component.dart';

class PlayerComponent extends SpriteAnimationComponent with HasGameRef<ThrillRunGame>, CollisionCallbacks {
  PlayerComponent({required this.onCollisionStartFunc});

  final double gravity = 300; // Сила гравитации

  double get jumpVelocity => LogicalSize.logicalHight(-1000); // Начальная скорость прыжка

  double velocityY = 100; // Текущая вертикальная скорость

  bool isOnGround = true; // Флаг, указывающий, находится ли игрок на земле

  final Function() onCollisionStartFunc;
  double timer = 0;

  late SpriteAnimation runAnimation;
  late SpriteAnimation jumpAnimation;

  @override
  Future<void> onLoad() async {
    debugMode = true;

    final spritesRun = [12, 1, 2, 3, 4, 5, 6];
    final spritesJump = [7, 8, 9, 10, 11, 4, 5, 6];

    for (var sprite in spritesRun) {
      await Flame.images.load('game/animation_run_and_jump/Group-$sprite.png');
    }
    for (var sprite in spritesJump) {
      await Flame.images.load('game/animation_run_and_jump/Group-$sprite.png');
    }

    var runSprites = spritesRun.map((i) => Sprite.load('game/animation_run_and_jump/Group-$i.png'));
    var jumpSprites = spritesJump.map((i) => Sprite.load('game/animation_run_and_jump/Group-$i.png'));

    runAnimation = SpriteAnimation.spriteList(
      await Future.wait(runSprites),
      stepTime: 0.1,
    );

    jumpAnimation = SpriteAnimation.spriteList(
      await Future.wait(jumpSprites),
      stepTime: 0.1,
    );

    animation = runAnimation;
    playing = true;
    anchor = Anchor.bottomLeft;
    position = Vector2(
      LogicalSize.logicalWidth(380),
      gameRef.canvasSize.y - 24,
    );
    size = LogicalSize.logicalSize(683, 300);
    add(RectangleHitbox(size: size / 1.5, position: size / 1.5, anchor: Anchor.center));
  }

  @override
  void update(double dt) {
    super.update(dt);

    velocityY += gravity * dt;
    y += velocityY * dt;

    if (y >= gameRef.canvasSize.y - 24) {
      y = gameRef.canvasSize.y - 24; // Возвращаем на уровень земли
      velocityY = 0; // Сбрасываем скорость
      isOnGround = true; // Устанавливаем флаг, что игрок на земле
      animation = runAnimation; // Включаем анимацию бега
      playing = true;
    } else {
      animation = jumpAnimation; // Включаем анимацию прыжка
      playing = true;
    }
    timer = dt + timer;
  }

  void jump() {
    if (isOnGround) {
      if (AppStorage.soundEnabled.val) {
        FlameAudio.play('jump.flac');
      }
      velocityY = jumpVelocity; // Устанавливаем начальную скорость прыжка
      isOnGround = false; // Флаг, что игрок в воздухе
      animation = jumpAnimation; // Включаем анимацию прыжка
      playing = true;
    }
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    onCollisionStartFunc.call();
    super.onCollisionStart(intersectionPoints, other);
  }
}
