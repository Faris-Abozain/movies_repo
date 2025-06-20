import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/modules/bloc/auth/auth_cubit.dart';
import 'package:movies/modules/bloc/auth/auth_state.dart';
import 'package:movies/modules/core/app_theme/app_colors.dart';
import 'package:movies/modules/routes/app_routes_name.dart';
import 'package:movies/modules/widgets/customBtn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login(BuildContext context) {
    BlocProvider.of<AuthCubit>(context).login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushReplacementNamed(context, AppRoutesName.home);
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Center(child: Image.asset("assets/logo/movie_logo.png")),
                  TextFormField(
                    onTapOutside: (PointerDownEvent event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    controller: emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: AppColors.yellow)),
                      prefixIcon: Image.asset("assets/icons/mail_icon.png"),
                      hintText: "email",
                      hintStyle: TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    onTapOutside: (PointerDownEvent event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    controller: passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: AppColors.yellow)),
                      prefixIcon: Image.asset("assets/icons/pass_icon.png"),
                      suffixIcon: const Icon(Icons.visibility, color: Colors.white),
                      hintText: "password",
                      hintStyle: const TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutesName.forgetPass);
                        },
                        child: Text(
                          "Forget Password?",
                          style: TextStyle(
                            color: AppColors.yellow,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primary,
                            decorationThickness: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: InkWell(
                      onTap: () => login(context),
                      child: state is AuthLoading
                          ? CircularProgressIndicator(color: AppColors.yellow)
                          : CustomBtn(text: "Login"),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don’t Have Account ? ",
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutesName.register);
                        },
                        child: Text("Create One",
                            style: TextStyle(
                                color: AppColors.yellow,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primary,
                                decorationThickness: 2)),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
