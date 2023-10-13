import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:last_task/utils/colors/app_colors.dart';

class GlobalTextField extends StatefulWidget {
  GlobalTextField(
      {Key? key,
      required this.hintText,
      required this.keyboardType,
      required this.textInputAction,
      required this.textAlign,
      this.isPassword = false,
      this.obscureText = false,
      this.maxLine = 1,
      required this.caption,
      required this.onChanged,
      this.read = false,
      this.check = false,
      this.suffixIcon,
      this.controller})
      : super(key: key);

  final String hintText;
  bool isPassword;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextAlign textAlign;
  final bool obscureText;
  final bool check;
  final String caption;
  final bool read;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final ValueChanged onChanged;
  final int maxLine;

  @override
  State<GlobalTextField> createState() => _GlobalTextFieldState();
}

class _GlobalTextFieldState extends State<GlobalTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.caption,
          style: const TextStyle(color: AppColors.passiveTextColor,fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16,),

        TextField(
          cursorColor: const Color(0xFF4F8962),
          maxLines: widget.maxLine,
          controller: widget.controller,
          inputFormatters: widget.check
              ? <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ]
              : [],
          readOnly: widget.read,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
              fontFamily: "DMSans"),
          textAlign: widget.textAlign,
          textInputAction: widget.textInputAction,
          keyboardType: widget.keyboardType,
          obscureText: widget.keyboardType == TextInputType.visiblePassword
              ? !widget.isPassword
              : false,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            suffixIcon: widget.suffixIcon,
            filled: true,
            fillColor: AppColors.c_0C1A30,
            hintText: widget.hintText,
            hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
                fontFamily: "DMSans"),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
