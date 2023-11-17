import 'dart:io';

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
        double h = Platform.isAndroid ? 0.8 : 0.75;

        return SafeArea(
          child: GestureDetector(
            onTap: keyboardOff,
            child: SizedBox(
              height: height ?? MediaQuery.of(context).size.height * h,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10,
                ),
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }

  static void keyboardOff() {
    FocusManager.instance.primaryFocus?.unfocus();
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
