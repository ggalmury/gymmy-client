import 'package:flutter/material.dart';
import 'package:gymmy_client/properties/app_color.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final IconData? prefixIcon;

  const SearchInput(
      {super.key, required this.controller, this.hintText, this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder b = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: AppColor.grey2,
      ),
    );
    return TextField(
      controller: controller,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: b,
        enabledBorder: b,
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
        filled: true,
        fillColor: AppColor.grey1,
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.black,
          size: 25,
        ),
      ),
    );
  }
}
