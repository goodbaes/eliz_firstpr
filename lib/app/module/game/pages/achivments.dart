import 'package:flutter/material.dart';
import 'package:game/data/storage/storage.dart';

import '../../../../generated/assets_flame_images.dart';
import '../widgets/back_button/back_button.dart';

class Achivments extends StatelessWidget {
  const Achivments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              AssetsFlameImages.bg_achievements_bookshelf,
              fit: BoxFit.cover,
            ),
            const BaseBackButton(),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  const SizedBox(height: 140),
                  Column(
                    children: [
                      Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Image.asset(AssetsFlameImages.game_alchemist_potion_bookcover),
                          text('Create ${AppStorage.achivmentsCount.val}/10 mixtures'),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Image.asset(
                            AssetsFlameImages.game_sage_heart_red_gem,
                          ),
                          text('Rate ${AppStorage.rateCount.val}/10 mixtures'),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget text(String text) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
