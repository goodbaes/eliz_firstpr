import 'package:flutter/material.dart';
import 'package:game/app/module/game/pages/quiz/quiz_question.dart';

import '../../../../../generated/assets_flame_images.dart';
import '../../../../app.dart';

class EndPopUp extends StatelessWidget {
  const EndPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    int correctAnswers = 0;

//get vars from navigator arguments
    final Object? args = ModalRoute.of(context)?.settings.arguments;
    if (args != null) {
      final Map<String, dynamic> arguments = args as Map<String, dynamic>;
      correctAnswers = arguments['correctAnswers'] as int;
    }
    return Scaffold(
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              AssetsFlameImages.game_BG_game,
              fit: BoxFit.cover,
            ),
            //gradient conteiner on half screen
            Container(
              height: MediaQuery.of(context).size.height / 4,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF000000),
                    Color(0x00000000),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  Spacer(),
                  Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        //You answered questions correctly
                        'You answered $correctAnswers questions and unlocked $correctAnswers facts in your gallery!',
                      ).formated(size: 40)),
                  Column(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.game);
                          },
                          child: Image.asset(AssetsFlameImages.start_over)),
                      const SizedBox(height: 20),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(AssetsFlameImages.main_menu)),
                      const SizedBox(height: 20),
                      InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.gallery);
                          },
                          child: Image.asset(
                              AssetsFlameImages.menu_button_Gallery_of_facts)),
                      const SizedBox(height: 100),
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
}
