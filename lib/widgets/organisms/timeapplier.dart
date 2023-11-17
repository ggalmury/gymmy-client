import 'package:flutter/material.dart';
import 'package:gymmy_client/widgets/molecules/btn_row.dart';
import 'package:gymmy_client/widgets/molecules/timepicker.dart';

class TimeApplier extends StatelessWidget {
  final VoidCallback onSubmit;
  final VoidCallback onCancel;

  const TimeApplier(
      {super.key, required this.onSubmit, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const TimePicker(),
        const SizedBox(height: 20),
        BtnRow(
          submitLabel: "적용",
          cancelLabel: "취소",
          onSubmit: onSubmit,
          onCancel: onCancel,
        ),
      ],
    );
  }
}
