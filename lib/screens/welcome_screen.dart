import 'package:flutter/material.dart';
import '../widgets/action_buttons_row.dart';
import '../widgets/background_image_container.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Upper section with background image
          const BackgroundImageContainer(imagePath: 'images/image1.png'),

          // Lower section with black background and content
          Expanded(
            flex: 1,
            child: Container(
              color: const Color(0xFF222831),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Lets Start Journey, Enjoy \n Your Trip With Us!',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    ActionButtonsRow(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
