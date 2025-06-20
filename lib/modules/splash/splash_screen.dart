import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../core/app_theme/app_colors.dart';
import '../routes/app_routes_name.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Center(child: ElasticIn(

              child: Image.asset("assets/logo/movie_logo.png"))),
          Spacer(),
          FadeInUp(
onFinish:(direction) {
  Navigator.pushNamed(context, AppRoutesName.login);
},
              child: Image.asset("assets/logo/route_logo (2).png")),
          FadeInUp(

              child: Image.asset("assets/logo/Supervised by Mohamed Nabil.png"))
        ],
      ),
    );
  }
}
