import 'package:flutter/material.dart';
import 'package:last_task/utils/colors/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';


class GlobalButton extends StatelessWidget {
  const GlobalButton({Key? key, required this.text, required this.onTap, this.color}) : super(key: key);

    final String text;
    final Color? color;
    final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: color ?? AppColors.c_3669C9
        ),
        child: Center(child: Text(text,style: const TextStyle(fontSize: 24,color: Colors.white),)),
      ),
    );
  }
}
