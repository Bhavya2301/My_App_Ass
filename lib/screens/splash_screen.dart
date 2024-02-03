import 'package:my_app/screens/search_screen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: const SearchScreen(),
      duration: 330,
      imageSize: 110,
      imageSrc: "assets/splash_image.png",
      backgroundColor: Colors.white,
    );
  }
}