import 'package:flutter/material.dart';
import 'package:gymmy_client/utils/enum/widget.dart';
import 'package:gymmy_client/widgets/atoms/buttons/primary_btn.dart';
import 'package:gymmy_client/widgets/atoms/buttons/text_btn.dart';

class BtnRow extends StatelessWidget {
  final String submitLabel;
  final String cancelLabel;
  final VoidCallback onSubmit;
  final VoidCallback onCancel;
  final bool? reversed;

  const BtnRow({
    super.key,
    required this.submitLabel,
    required this.cancelLabel,
    required this.onSubmit,
    required this.onCancel,
    this.reversed,
  });

  List<Widget> _btnList() => [
        Expanded(
          child: TextBtn(
            label: cancelLabel,
            onPressed: onCancel,
            fontColor: Colors.red,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: PrimaryBtn(
            label: submitLabel,
            onPressed: onSubmit,
            widgetColor: WidgetColor.appColor,
            widgetSize: WidgetSize.small,
          ),
        )
      ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: reversed == true ? _btnList().reversed.toList() : _btnList(),
    );
  }
}
