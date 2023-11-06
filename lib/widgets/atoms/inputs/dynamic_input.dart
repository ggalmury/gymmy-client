import 'package:flutter/material.dart';
import 'package:gymmy_client/properties/app_color.dart';

class DynamicInput extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final double? width;
  final TextAlign? textAlign;
  final Color? borderColor;

  const DynamicInput(
      {super.key,
      required this.controller,
      this.keyboardType,
      this.width,
      this.textAlign,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder b = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: borderColor ?? AppColor.grey2,
      ),
    );

    return SizedBox(
      width: width,
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 14),
        keyboardType: keyboardType,
        textAlign: textAlign ?? TextAlign.start,
        decoration: InputDecoration(
          isDense: true,
          focusedBorder: b,
          enabledBorder: b,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          filled: true,
          fillColor: AppColor.grey1,
        ),
      ),
    );
  }
}
