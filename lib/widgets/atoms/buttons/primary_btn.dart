import 'package:flutter/material.dart';
import 'package:gymmy_client/properties/app_color.dart';
import 'package:gymmy_client/utils/enum/widget.dart';

class PrimaryBtn extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final WidgetColor widgetColor;
  final WidgetSize widgetSize;

  const PrimaryBtn(
      {super.key,
      required this.label,
      required this.onPressed,
      required this.widgetColor,
      required this.widgetSize});

  Color _backgroundColor() {
    switch (widgetColor) {
      case WidgetColor.appColor:
        return AppColor.appColor;
    }
  }

  Color _foregroundColor() {
    switch (widgetColor) {
      case WidgetColor.appColor:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widgetSize == WidgetSize.big ? double.infinity : null,
      height: widgetSize == WidgetSize.big ? 50 : 40,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
            backgroundColor: _backgroundColor(),
            foregroundColor: _foregroundColor(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
