import 'package:flutter/material.dart';
import '../core/app_theme/app_colors.dart';

class CustomBtn extends StatelessWidget {
  String text;
  CustomBtn({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 360,
      decoration: BoxDecoration(
          color: AppColors.yellow,
          borderRadius: BorderRadius.circular(16)
      ),
      child: Center(
          child: Text(
            text,
            style: TextStyle(color: AppColors.primary, fontSize: 20),
          )),
    );
  }
}
