import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymmy_client/utils/enum/widget.dart';
import 'package:gymmy_client/widgets/atoms/buttons/primary_btn.dart';
import 'package:gymmy_client/widgets/atoms/buttons/text_btn.dart';

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

  static alertModalHandler(
    BuildContext context,
    String title, {
    String? subTitle,
    bool? cancelable,
    VoidCallback? onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: SizedBox(
            width: 300,
            height: 180,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryBtn(
                          label: "예",
                          onPressed: () => Navigator.pop(ctx),
                          widgetColor: WidgetColor.appColor,
                          widgetSize: WidgetSize.small,
                        ),
                      ),
                      if (cancelable == true)
                        Expanded(
                          child: TextBtn(
                            label: "아니요",
                            onPressed: () => Navigator.pop(ctx),
                            fontColor: Colors.black,
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),
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
