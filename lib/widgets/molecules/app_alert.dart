import 'package:flutter/material.dart';
import 'package:gymmy_client/utils/enum/widget.dart';
import 'package:gymmy_client/widgets/atoms/buttons/primary_btn.dart';
import 'package:gymmy_client/widgets/atoms/buttons/text_btn.dart';

class AppAlert extends StatelessWidget {
  final String title;
  final String? subTitle;
  final bool? cancelable;
  final VoidCallback? onConfirm;
  final String? submitBtnLabel;

  const AppAlert(
      {super.key,
      required this.title,
      this.subTitle,
      this.cancelable,
      this.onConfirm,
      this.submitBtnLabel});

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
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
                      label: submitBtnLabel ?? "예",
                      onPressed: () {
                        if (onConfirm != null) onConfirm!();
                        Navigator.pop(context);
                      },
                      widgetColor: WidgetColor.appColor,
                      widgetSize: WidgetSize.small,
                    ),
                  ),
                  if (cancelable == true)
                    Expanded(
                      child: TextBtn(
                        label: "아니요",
                        onPressed: () => Navigator.pop(context),
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
  }
}
