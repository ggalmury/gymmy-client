import 'package:flutter/material.dart';
import 'package:gymmy_client/utils/enum/widget.dart';
import 'package:gymmy_client/utils/helper/screen_util.dart';
import 'package:gymmy_client/widgets/atoms/buttons/primary_btn.dart';
import 'package:gymmy_client/widgets/molecules/btn_row.dart';
import 'package:gymmy_client/widgets/organisms/timepicker.dart';

class SetPlan extends StatefulWidget {
  const SetPlan({super.key});

  @override
  State<SetPlan> createState() => _SetPlanState();
}

class _SetPlanState extends State<SetPlan> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryBtn(
          label: "시간 선택",
          onPressed: () => ScreenUtil.bottomSheetHandler(
            context,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TimePicker(),
                  const SizedBox(height: 20),
                  BtnRow(
                    submitLabel: "적용",
                    cancelLabel: "취소",
                    onSubmit: () {},
                    onCancel: () {},
                  ),
                ],
              ),
            ),
            height: 280,
          ),
          widgetColor: WidgetColor.appColor,
          widgetSize: WidgetSize.small,
        ),
      ],
    );
  }
}
