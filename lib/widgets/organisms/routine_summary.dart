import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymmy_client/bloc/selected_date_bloc.dart';
import 'package:gymmy_client/properties/app_color.dart';
import 'package:gymmy_client/utils/enum/widget.dart';
import 'package:gymmy_client/utils/helper/screen_util.dart';
import 'package:gymmy_client/widgets/atoms/buttons/primary_btn.dart';
import 'package:gymmy_client/widgets/molecules/svg_row.dart';
import 'package:gymmy_client/widgets/templates/routine_info.dart';
import 'package:intl/intl.dart';

class RoutineSummary extends StatelessWidget {
  const RoutineSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.grey1,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<SelectedDateBloc, SelectedDateState>(
          builder: (context, state) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: DateFormat("MM.dd")
                                  .format(state.selectedDate),
                              style: const TextStyle(
                                color: AppColor.appColor,
                              ),
                            ),
                            const TextSpan(
                              text: " 의 운동",
                            ),
                          ],
                        ),
                      )),
                  const Text(
                    "진행중🔥",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgRow(
                    label: "헬스",
                    svgName: "dumbell",
                  ),
                  SvgRow(
                    label: "1시간",
                    svgName: "clock",
                  ),
                ],
              ),
              PrimaryBtn(
                label: "자세히 보기",
                onPressed: () => ScreenUtil.bottomSheetHandler(
                  context,
                  const RoutineInfo(),
                ),
                widgetColor: WidgetColor.appColor,
                widgetSize: WidgetSize.big,
              )
            ],
          ),
        ),
      ),
    );
  }
}
