import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ScreenUtil {
  static bottomSheetHandler(BuildContext context, Widget child,
      {double? height}) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext ctx) {
        return SizedBox(
          height: height ?? MediaQuery.of(context).size.height * 0.8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: child,
          ),
        );
      },
    );
  }

  static Widget svgFactory(String name, double size,
      {ColorFilter? colorFilter}) {
    return SvgPicture.asset(
      "assets/svg/$name.svg",
      width: size,
      height: size,
      colorFilter: colorFilter,
    );
  }
}
