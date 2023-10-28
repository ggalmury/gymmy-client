import 'package:flutter/material.dart';

class TextBtn extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double? width;
  final Color? fontColor;

  const TextBtn(
      {super.key,
      required this.label,
      required this.onPressed,
      this.width,
      this.fontColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          side: MaterialStateProperty.all(BorderSide.none),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: fontColor,
          ),
        ),
      ),
    );
  }
}
