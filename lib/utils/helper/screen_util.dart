import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ScreenUtil {
  static bottomSheetHandler(BuildContext context, Widget child,
      {double? height}) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (ctx) {
        return SafeArea(
          child: SizedBox(
            height: height ?? MediaQuery.of(context).size.height * 0.8,
            child: child,
          ),
        );
      },
    );
  }

  static modalHandler(BuildContext context, Widget child) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
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
      "assets/svgs/$name.svg",
      width: size,
      height: size,
      colorFilter: colorFilter,
    );
  }
}
