import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/modules/bloc/auth/auth_cubit.dart';
import 'package:movies/modules/bloc/auth/auth_state.dart';
import 'package:movies/modules/core/app_theme/app_colors.dart';
import 'package:movies/modules/widgets/customBtn.dart';
import 'package:movies/modules/routes/app_routes_name.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final emailController = TextEditingController();

  void reset(BuildContext context) {
    BlocProvider.of<AuthCubit>(context).resetPassword(
      emailController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(color: AppColors.yellow),
        title: Text(
          "Forget Password",
          style: TextStyle(color: AppColors.yellow, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Please check your email to reset password"),
                ),
              );
              Navigator.pushReplacementNamed(context, AppRoutesName.login);
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
                  const SizedBox(height: 40),
                  Center(child: Image.asset("assets/images/Forgot password-bro 1.png")),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      onTapOutside: (PointerDownEvent event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      controller: emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: AppColors.yellow),
                        ),
                        prefixIcon: Image.asset("assets/icons/mail_icon.png"),
                        hintText: "email",
                        hintStyle: const TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.yellow),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: InkWell(
                      onTap: () => reset(context),
                      child: state is AuthLoading
                          ? CircularProgressIndicator(color: AppColors.yellow)
                          : CustomBtn(text: "Verify Email"),
                    ),
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
