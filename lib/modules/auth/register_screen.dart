import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/modules/bloc/auth/auth_cubit.dart';
import 'package:movies/modules/bloc/auth/auth_state.dart';
import 'package:movies/modules/core/app_theme/app_colors.dart';
import 'package:movies/modules/routes/app_routes_name.dart';
import 'package:movies/modules/widgets/customBtn.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmController = TextEditingController();
  final phoneController = TextEditingController();

  void register(BuildContext context) {
    if (passController.text != confirmController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }
    BlocProvider.of<AuthCubit>(context).register(
      nameController.text.trim(),
      emailController.text.trim(),
      passController.text.trim(),
      phoneController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(color: AppColors.yellow),
        title: Text("Register", style: TextStyle(color: AppColors.yellow, fontSize: 16)),
        centerTitle: true,
      ),
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
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/images/gamer (1) (2).png"),
                  Image.asset("assets/images/gamer (1) (1).png"),
                  Image.asset("assets/images/gamer (1).png"),
                ],
              ),),

              _buildTextField(nameController, "Name", "assets/icons/🦆 icon _Identification_.png"),
                  const SizedBox(height: 20),
                  _buildTextField(emailController, "email", "assets/icons/mail_icon.png"),
                  const SizedBox(height: 20),
                  _buildTextField(passController, "password", "assets/icons/pass_icon.png", isPassword: true),
                  const SizedBox(height: 20),
                  _buildTextField(confirmController, "confirm password", "assets/icons/conf_icon.png", isPassword: true),
                  const SizedBox(height: 20),
                  _buildTextField(phoneController, "phone number", "assets/icons/phone_icon.png"),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: InkWell(
                      onTap: () => register(context),
                      child: state is AuthLoading
                          ? CircularProgressIndicator(color: AppColors.yellow)
                          : CustomBtn(text: "Create Account"),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have Account?", style: TextStyle(color: Colors.white, fontSize: 12)),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutesName.login);
                        },
                        child: Text(" Login", style: TextStyle(color: AppColors.yellow, fontSize: 12)),
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

  Widget _buildTextField(
      TextEditingController controller,
      String hint,
      String iconPath, {
        bool isPassword = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        onTapOutside: (PointerDownEvent event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: Image.asset(iconPath),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.yellow),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(16),
          ),
          suffixIcon: isPassword ? const Icon(Icons.visibility, color: Colors.white) : null,
        ),
      ),
    );
  }
}
