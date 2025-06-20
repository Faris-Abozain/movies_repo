import 'package:flutter/material.dart';
import 'package:movies/modules/core/app_theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Text(
          "Welcome to Home!",
          style: TextStyle(color: AppColors.yellow, fontSize: 22),
        ),
      ),
    );
  }
}
