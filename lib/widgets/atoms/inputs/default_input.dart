import 'package:flutter/material.dart';
import 'package:gymmy_client/properties/app_color.dart';

class DefaultInput extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final double? width;

  const DefaultInput(
      {super.key, required this.controller, this.keyboardType, this.width});

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder b = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: AppColor.grey2,
      ),
    );

    return SizedBox(
      width: width,
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 14),
        keyboardType: keyboardType,
        decoration: InputDecoration(
          focusedBorder: b,
          enabledBorder: b,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
          filled: true,
          fillColor: AppColor.grey1,
        ),
      ),
    );
  }
}
