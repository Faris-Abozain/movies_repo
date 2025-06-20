import 'package:flutter/cupertino.dart';
import 'package:movies/modules/auth/forget_password.dart';
import 'package:movies/modules/auth/register_screen.dart';
import 'package:movies/modules/screens/home_screen.dart';


import '../auth/login_screen.dart';
import '../splash/splash_screen.dart';
import 'app_routes_name.dart';

class AppRoutes{
  static Map<String, Widget Function(BuildContext)> routes = {
    AppRoutesName.splash:(_)=>const SplashScreen(),
    AppRoutesName.login:(_)=>const LoginScreen(),
    AppRoutesName.register:(_)=>const RegisterScreen(),
    AppRoutesName.forgetPass:(_)=>const ForgetPassword(),
    AppRoutesName.home:(_)=>const HomeScreen(),




  };
}