import 'package:flutter/material.dart';
import 'package:gymmy_client/properties/app_color.dart';
import 'package:gymmy_client/utils/helper/screen_util.dart';

class SvgRow extends StatelessWidget {
  final String label;
  final String svgName;
  final double? svgSize;

  const SvgRow(
      {super.key, required this.label, required this.svgName, this.svgSize});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: AppColor.grey3,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: ScreenUtil.svgFactory(svgName, svgSize ?? 16),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
