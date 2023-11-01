import 'package:flutter/material.dart';
import 'package:gymmy_client/properties/app_color.dart';

class ToggleBtn extends StatelessWidget {
  final String label;
  final bool toggle;
  final VoidCallback onPressed;

  const ToggleBtn(
      {super.key,
      required this.label,
      required this.toggle,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: toggle == true ? AppColor.appColor : AppColor.grey1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: toggle == true ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
